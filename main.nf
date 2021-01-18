#!/usr/bin/env nextflow

nextflow.enable.dsl=2
params.str = 'Hello world'
params.output = '/code/results'

process splitLetters {
    output:
    path('chunk_*')

    """
    printf '${params.str}' | split -b 6 - chunk_
    """
}


process convertToUpper {
    input:
    path(x)

    output:
    stdout

    """
    cat $x | tr '[a-z]' '[A-Z]' > '${params.output}'
    """
}

workflow {
  main:
  splitLetters | convertToUpper | view { it.trim() }
}