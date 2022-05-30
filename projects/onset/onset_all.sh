#!/bin/bash
#SBATCH --output=/network/lustre/iss02/charpier/analyses/vn_onset/slurm_output/output-%j-%x.txt
JOBID1=$(sbatch --parsable onset_project_spikes_slurm.sh)
JOBID2=$(sbatch --dependency afterok:${JOBID1} onset_project_grandaverage_slurm.sh)