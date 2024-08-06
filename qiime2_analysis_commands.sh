# Activate the QIIME2 environment
conda activate qiime2-2023.2

# Import metadata into QIIME2
qiime metadata tabulate \
  --m-input-file metadata.tsv \
  --o-visualization metadata.qzv

# Import data into QIIME2
qiime tools import \
  --type "SampleData[SequencesWithQuality]" \
  --input-format SingleEndFastqManifestPhred33V2 \
  --input-path ./manifest.tsv \
  --output-path ./demux_seqs.qza

# Summarize data
qiime demux summarize \
  --i-data ./demux_seqs.qza \
  --o-visualization ./demux_seqs.qzv

# Sequence quality control and feature table generation
qiime dada2 denoise-single \
  --i-demultiplexed-seqs ./demux_seqs.qza \
  --p-trunc-len 150 \ # This is chosen based on the box plot generated
  --o-table ./dada2_table.qza \
  --o-representative-sequences ./dada2_rep_set.qza \
  --o-denoising-stats ./dada2_stats.qza

qiime metadata tabulate \
  --m-input-file ./dada2_stats.qza \
  --o-visualization ./dada2_stats.qzv

# Summarize feature table
qiime feature-table summarize \
  --i-table ./dada2_table.qza \
  --m-sample-metadata-file ./metadata.tsv \
  --o-visualization ./dada2_table.qzv

# Visualize representative sequences
qiime feature-table tabulate-seqs \
  --i-data ./dada2_rep_set.qza \
  --o-visualization ./dada2_rep_set.qzv

# Taxonomic analysis

# Download pre-trained classifier
wget -O "gg-13-8-99-515-806-nb-classifier.qza" \
  https://data.qiime2.org/classifiers/sklearn-1.4.2/greengenes/gg-13-8-99-515-806-nb-classifier.qza

# Classification of Amplicon Sequence Variant (ASV)
qiime feature-classifier classify-sklearn \
  --i-reads ./dada2_rep_set.qza \
  --i-classifier ./gg-13-8-99-515-806-nb-classifier.qza \
  --o-classification ./taxonomy.qza

# Visualize taxonomy
qiime metadata tabulate \
  --m-input-file taxonomy.qza \
  --o-visualization taxonomy.qzv

# Generate representative sequences visualization
qiime feature-table tabulate-seqs \
  --i-data ./dada2_rep_set.qza \
  --o-visualization ./dada2_rep_set.qzv

# Taxonomy bar chart

# Filter samples based on minimum frequency
qiime feature-table filter-samples \
  --i-table ./dada2_table.qza \
  --p-min-frequency 2000 \
  --o-filtered-table ./table_2k.qza

# Visualization
qiime taxa barplot \
  --i-table ./table_2k.qza \
  --i-taxonomy ./taxonomy.qza \
  --m-metadata-file ./metadata.tsv \
  --o-visualization ./taxa_barplot.qzv

# Total frequency-based filtering

# Filter samples by minimum frequency
qiime feature-table filter-samples \
  --i-table table.qza \
  --p-min-frequency 6283 \
  --o-filtered-table sample-frequency-filtered-table.qza

# Filter features by minimum frequency
qiime feature-table filter-features \
  --i-table table.qza \
  --p-min-frequency 7 \
  --o-filtered-table feature-frequency-filtered-table.qza

# Taxonomy-based filtering of features and tables

# Exclude mitochondria
qiime taxa filter-table \
  --i-table table.qza \
  --i-taxonomy taxonomy.qza \
  --p-exclude mitochondria \
  --o-filtered-table table-no-mitochondria.qza

# Exclude mitochondria and chloroplast
qiime taxa filter-table \
  --i-table table.qza \
  --i-taxonomy taxonomy.qza \
  --p-exclude mitochondria,chloroplast \
  --o-filtered-table table-no-mitochondria-no-chloroplast.qza
