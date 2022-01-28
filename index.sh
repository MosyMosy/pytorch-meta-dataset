#!/bin/bash
#SBATCH --mail-user=Moslem.Yazdanpanah@gmail.com
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-type=REQUEUE
#SBATCH --mail-type=ALL
#SBATCH --job-name=index
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --mem=127000M
#SBATCH --time=0-04:00
#SBATCH --account=rrg-ebrahimi

nvidia-smi

source ~/ENV_MD/bin/activate

echo "------------------------------------< Data preparation>----------------------------------"
echo "Copying the source code"
date +"%T"
cd $SLURM_TMPDIR

cp -r ~/scratch/metadatasets/records/ .
cp -r ~/scratch/pytorch-meta-dataset .
cd pytorch-meta-dataset

bash scripts/make_records/make_index_files.sh ../metadatasets/records

echo "-----------------------------------<End of run the program>---------------------------------"
date +"%T"
echo "--------------------------------------<backup the result>-----------------------------------"
date +"%T"
cd $SLURM_TMPDIR
cp -r $SLURM_TMPDIR/records/ ~/scratch/metadatasets/

