#!/bin/bash
#SBATCH --job-name=onset_project
#SBATCH --partition=bigmem,normal
#SBATCH --time=99:99:99
#SBATCH --mem=32G
#SBATCH --cpus-per-task=2
#SBATCH --chdir=.
#SBATCH --output=/network/lustre/iss01/charpier/analyses/vn_onset/slurm_output/output-%j_%a-%x.txt
#SBATCH --error=/network/lustre/iss01/charpier/analyses/vn_onset/slurm_error/error-%j_%a-%x.txt
#SBATCH --array=1-32


module load MATLAB/R2020b
matlab -nodesktop -softwareopengl -nosplash -nodisplay -r "onset_project_spikes($SLURM_ARRAY_TASK_ID);"
sleep 5;
