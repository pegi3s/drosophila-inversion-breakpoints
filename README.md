# Drosophila Inversion Breakpoints (DIB) pipeline

This image facilitates the usage of DIB (Drosophila Inversion Breakpoints) an automated pipeline for locating inversion breakpoints when starting with sequence reads.

Below are the instructions for using the `pegi3s/dib` Docker image. The full documentation can be checked in [this manual](DIB_manual.pdf).

## Using the DIB image in Linux

You should adapt and run the following command: `docker run -v /var/run/docker.sock:/var/run/docker.sock -v /your/data/dir:/data pegi3s/dib bash -c "./main"`

In this command, you should replace `/your/data/dir` to point to the directory that contains the input files and folders that you want to analyze.

*Note*: The pipeline results can be found in the `/your/data/dir` directory in the files prefixed with the word "results" (e.g., "results.SRRnumber.fasta"), where potential inversion breakpoints, alongside additional contextual information is given.

You should also adjust the following parameters within the configuration file (`config`): 

- dir: Set the directory path to the project directory.
- get_reference: Specify "Y" or "y" if automatic downloading of the reference genome is required; choose "N" or "n" if the reference genome is already available.
- reference: If "Y" or "y" is chosen for (get_reference) the NCBI RefSeq Assembly number should be provided for the automatic download of the reference genome. If "N" or "n" is selected for (get_reference) the filename of the reference genome should be provided. The reference genome should be stored in a folder named "reference_file" within the project directory.
- list: Indicate the filename containing the list of SRR numbers corresponding to the data. This list file must be located in the project directory.
- format: Choose either "fastq" or "fasta" based on the format of the SRR data.
- Wgsim options (default values indicated in brackets):

  - sequence_size1: Specifies the length of the first read. [70]
  - sequence_size2: Specifies the length of the second read (for paired-end sequencing). [70]
  - rate_mutations: Sets the mutation rate. [0.0010]
  - fraction_indels: Defines the fraction of indels (insertions/deletions) in the simulated reads. [0.15]
  - prob_indel: Sets the probability of an indel happening. [0.30]
  - error_rate: Specifies the sequencing error rate. [0.020]
  - standard_deviation: Sets the standard deviation of the fragment size. [-1]
  - read_pairs: Determines the number of read pairs to generate. [1000000]
  - seed: Provides a random seed for reproducibility. [-1]
- Filtering Options: Comprehensive details regarding filtering options are outlined by the parameters: sequence identity (seq_ident), alignment length (align_length), and the maximum number of genome hits (gen_hits). This filtering process helps identify the most relevant candidates for further analysis. Note: Only cases where four sequence types are identified are considered.

For testing purposes, the `simulate_data` script can be used to generate synthetic sequencing data featuring customizable genetic sequences adorned with inversions. In order to use this script you should adapt and run the following command:
```shell
docker run -v /var/run/docker.sock:/var/run/docker.sock -v /your/data/dir:/data pegi3s/dib bash -c "./simulate_data <reference_file> /your/data/dir <first.breakpoint.pos> <second.breakpoint.pos> <options>"
```

In this command, you should replace:

- `/your/data/dir` to point to the directory that contains the input files and folders that you want to analyze. (please note that it appears twice)
- `<reference_file>` with the name of the input FASTA file you want to analyze (must be in the project directory).
- `<first.breakpoint.pos>`  with the position of the first breakpoint to be generated.
- `<second.breakpoint.pos>` with the position of the second breakpoint to be generated.
- `<options>` with the specific options of the Wgsim tool. You can substitute this parameter by just the letter "s", meaning that you want to use the standard values. Otherwise, you can add the Wgsim options (already explained above), by this order: sequence_size1, sequence_size2, rate_mutations, fraction_indels, prob_indel, error_rate, standard_deviation, read_pairs, seed.
