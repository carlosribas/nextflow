#!/usr/bin/env nextflow

params.script1 = file('scripts/stage1.R')
params.script2 = file('scripts/stage2.R')

process stage1 {
    container = 'qrouchon/r-base-plus'
    tag "stage 1 process"
    publishDir "./"

    input:

    output:
    path 'results/stage_1_output.txt' into stage1_output_ch

    script:
    """
    Rscript ${params.script1} --input 'Every good boy does fine.'
    """
}

process stage2 {
    container = 'qrouchon/r-base-plus'
    tag "stage 2 process"
    publishDir "./"

    input:
    path stage1_output_ch

    output:
    path 'results/stage_2_output.txt' into stage2_output_ch

    script:
    """
    Rscript ${params.script2} --file '${stage1_output_ch}'
    """
}
