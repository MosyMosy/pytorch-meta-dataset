#!/bin/bash
#SBATCH --mail-user=Moslem.Yazdanpanah@gmail.com
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-type=REQUEUE
#SBATCH --mail-type=ALL
#SBATCH --job-name=coco
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --mem=127000M
#SBATCH --time=0-10:00
#SBATCH --account=rrg-ebrahimi

nvidia-smi

source ~/ENV_MD/bin/activate

echo "------------------------------------< Data preparation>----------------------------------"
echo "Copying the source code"
date +"%T"
cd $SLURM_TMPDIR

# cp -r ~/scratch/metadatasets/quickdraw/ .
cp -r ~/scratch/metadatasets/mscoco/ .
cd mscoco
unzip train2017.zip
unzip annotations_trainval2017.zip
mv annotations/* .

cd $SLURM_TMPDIR

cp -r ~/scratch/meta-dataset .
cd meta-dataset



python -m meta_dataset.dataset_conversion.convert_datasets_to_records \
  --dataset=mscoco \
  --mscoco_data_root=../mscoco \
  --splits_root=../SPLITS \
  --records_root=../records3

echo "-----------------------------------<End of run the program>---------------------------------"
date +"%T"
echo "--------------------------------------<backup the result>-----------------------------------"
date +"%T"
cd $SLURM_TMPDIR
cp -r $SLURM_TMPDIR/records3/ ~/scratch/metadatasets/

