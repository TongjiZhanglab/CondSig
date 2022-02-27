#!/bin/bash

focus_factor_label=${1}
topic_number_min=${2}
topic_number_max=${3}
voca_number=${4}
output_path=${5}
level=${6}
cwd=`pwd`

mkdir -p ${output_path} && cd ${output_path}

### 1. Index the words in the documents
python /mnt/Storage/home/yuzhaowei/software/BTM/script/indexDocs.py \
${focus_factor_label}_${level}_doc.txt \
${focus_factor_label}_${level}_dwid.txt \
${focus_factor_label}_${level}_voca.txt

### 2. Topic learning
mkdir -p ${level}/
for topic_number in $(seq ${topic_number_min} ${topic_number_max});
do
	/mnt/Storage/home/yuzhaowei/software/BTM/src/btm est ${topic_number} ${voca_number} 1 0.01 10 501 ${focus_factor_label}_${level}_dwid.txt ${level}/ && \
	/mnt/Storage/home/yuzhaowei/software/BTM/src/btm inf sum_b ${topic_number} ${focus_factor_label}_${level}_dwid.txt ${level}/ & ### 3. Inference topic proportions for documents
done
wait
cd ${cwd}/
