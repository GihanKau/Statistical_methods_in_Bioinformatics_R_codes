## Bioconductor (BioC)

# Bioconductor (BioC) is an open source, community driven software project which provides
# a framework of tools and databases for the analysis of biological data in R
# Bioconductor packages can be broadly split into 4 groups.
      
      #1.Software (Tools for the analysis/visualisation of biological data)
      #2.Annotation Data (Tools for the integration of biological metadata)
      #3.Experiment Data (Example and actual data from experiments)
      #4.Workflow

# R has CRAN (comprehensive R archive network)

# install Bioc

install.packages("BiocManager")
require(BiocManager)
library(BiocManager)

# check your bioconductor version
BiocManager::version() #3.14

# Bioc has packages and these packages include methods for handling common genomics data types.
      # 1.Fasta and FastQ
      # 2.BED, BED6 and narrowPeak/broadPeak
      # 3.GFF
      # 4.SAM and BAM 

# Genomic sequences stored as FASTA files are handled using the Biostrings package.
BiocManager::install("Biostrings")
library(Biostrings)

# Genomic intervals stored as BED files are handled using the rtracklayer and
# GenomicRanges packages.
# Genomic scores stored as wig or bigWig files are handled using the rtracklayer and
# GenomicRanges packages.

BiocManager::install("rtracklayer")
library(rtracklayer)
BiocManager::install("GenomicRanges")
library(GenomicRanges)

# GFF files containing gene models are handled using the GenomicFeatures package.
BiocManager::install("GenomicFeatures")
library(GenomicFeatures)

# FastQ files containing gene models are handled using the ShortRead package.
BiocManager::install("ShortRead")
library(ShortRead)

# SAM and BAM files are handled using the GenomicAlignments package.
BiocManager::install("GenomicAlignments")
library(GenomicAlignments)

# As well as software packages, we know Bioconductor maintains a number of annotation packages.
# This includes microarray annotation, gene to ID mappings, genes' functional annotation,
# genome sequence information and gene/trancript models.


## PDF 1 Exercise

# installation of annotation package for mouse UCSC mm10 and human UCSC hg19
# Genomic sequence information is held within the BSgenome packages. full genome
# sequences for many model organisms are contained within the BSgenome packages.

BiocManager::install("BSgenome.Mmusculus.UCSC.mm10")
BiocManager::install("BSgenome.Hsapiens.UCSC.hg19")

## PDF 2

# Genomic sequenses in BSgenome can be handled using functions in Biostrings package.
library(BSgenome.Mmusculus.UCSC.mm10)
class(BSgenome.Mmusculus.UCSC.mm10)

# seqnames() function to retrieve all contig names.
contigNames = seqnames(BSgenome.Mmusculus.UCSC.mm10)
contigNames[1:22]

# contig lengths using seqlengths() function.
contigLengths = seqlengths(BSgenome.Mmusculus.UCSC.mm10)
contigLengths[1:4]

# count the number of contigs
contigNumber = length(seqnames(BSgenome.Mmusculus.UCSC.mm10))
contigNumber

# Give the sum of lengths of the 3 smallest chromosomes
contigLengths = seqlengths(BSgenome.Mmusculus.UCSC.mm10)
contigLengths[order(contigLengths,decreasing = FALSE)][1:3]

sum(contigLengths[order(contigLengths,decreasing = FALSE)][1:3])


# retrieve sequence information using either the $ or [[]] accessors according to their contig names.
chr19_Seq = BSgenome.Mmusculus.UCSC.mm10$chr19
chr19_Seq  # or

chr19_Seq = BSgenome.Mmusculus.UCSC.mm10[["chr19"]]
chr19_Seq

# The returned sequence object is a DNAString object from the Biostrings package
?DNAString
class(chr19_Seq)

# We can subset a DNAString object just like indexing a normal vector
chr19_Seq[1:10000000]

#  or we can use the Biostrings function subseq() on our DNAString.
subseq(chr19_Seq,start=1,end=10000000)

#### handling sequence data ####

# frequency of bases using the alphabetFrequency() function
alpFreq = alphabetFrequency(chr19_Seq)
alpFreq

# How many unknown bases (base N) are in chromosome chr19_Seq
alpFreq["N"]

# Create a barchart of the total number of the A,T,C,G bases on chromosome 19

library(ggplot2)
atcgFreq = alpFreq[c("A","T","C","G")]
atcgFreqDF = data.frame(Bases=names(atcgFreq),Frequency=atcgFreq)
ggplot(atcgFreqDF,aes(y=Frequency,x=Bases,fill=Bases))+geom_bar(stat = "identity")+theme_minimal()


# complement,reverse and reverse complement of sequence
chr19_Seq[10000000:10000010]

chr19_SeqComp = complement((chr19_Seq[10000000:10000010]))
chr19_SeqComp

chr19_SeqRev = reverse((chr19_Seq[10000000:10000010]))
chr19_SeqRev

chr19_SeqRevComp = reverseComplement(chr19_Seq[10000000:10000010])
chr19_SeqRevComp


# translation of our sequence using the translate()
length(chr19_Seq[10000000:10000008])

chr19_SeqTranslation = translate(chr19_Seq[10000000:10000008])
chr19_SeqTranslation

# match and count the occurrence of patterns in our sequence using
# matchPattern() and countPattern()

chr19_Count = countPattern(pattern="ATCTGCAATG",subject=chr19_Seq)
chr19_Count

chr19_Match = matchPattern(pattern="ATCTGCAATG",subject=chr19_Seq)
chr19_Match

# We may not always expect a perfect match for our sequence. We can search for close
# matches by setting the degree of specificity to the max.mismatch and min.mismatch arguments

# By default both max.mismatch and min.mismatch are set to 0.

chr19_Count = countPattern(pattern="ATCTGCAATG",
                           subject=chr19_Seq,
                           max.mismatch = 2,
                           min.mismatch = 0)
chr19_Count

chr19_Match = matchPattern(pattern="ATCTGCAATG",
                           subject=chr19_Seq,
                           max.mismatch = 2,
                           min.mismatch = 0)
chr19_Match

# use IUPAC codes to account for ambiguity in the sequence we will match
# We can see the availble IUPAC code by viewing the Biostring named vector

IUPAC_CODE_MAP

chr19_Count = countPattern(pattern="RYKHBNKYSRR",
                           subject=chr19_Seq,
                           fixed=FALSE)
chr19_Count

chr19_Match = matchPattern(pattern="RYKHBNKYSRR",
                           subject=chr19_Seq,
                           fixed=FALSE)
chr19_Match

# Typically we will search both strands (Watson and Crick/forward and reverse) to identify anypatterns

chr19_Count_Watson = countPattern(pattern="ATCTGCAATG",
                                  subject=chr19_Seq)
chr19_Count_Crick = countPattern(pattern="ATCTGCAATG",
                                 subject=reverseComplement(chr19_Seq)
                                 )

Total_chr19_Count = chr19_Count_Watson
Total_chr19_Count


#### read and write to a FASTA ####

# First we will convert our DNAString to a DNAStringSet object
chr19_SeqSet = DNAStringSet(chr19_Seq[10000000:10000010])
# Then set names (fasta header)
names(chr19_SeqSet) = "chr19"

# then write

getwd()
setwd("D:/Degree notes/Fourth year/First sem/BT 4019  - Statistical Methods in Bioinformatics")
writeXStringSet(chr19_SeqSet,filepath = "chr19_Seq.fa")

chr19_FromFASTA = readDNAStringSet(filepath = "chr19_Seq.fa")
chr19_FromFASTA$chr19
