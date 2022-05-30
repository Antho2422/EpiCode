#!/bin/bash
#SBATCH --job-name=onset_avg
#SBATCH --partition=normal,bigmem
#SBATCH --time=99:99:99
#SBATCH --mem=16G
#SBATCH --cpus-per-task=2
#SBATCH --chdir=.
#SBATCH --output=/network/lustre/iss02/charpier/analyses/vn_onset/slurm_output/output-%j-%x.txt
#SBATCH --error=/network/lustre/iss02/charpier/analyses/vn_onset/slurm_error/error-%j-%x.txt


module load MATLAB/R2020b
matlab -nodesktop -softwareopengl -nosplash -nodisplay -r "onset_project_grandaverage;"
sleep 5;
