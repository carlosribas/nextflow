#!/usr/bin/env nextflow

params.file = file('input.fasta')

/*
 * split a fasta file in multiple files
 */
process splitSequences {
    container 'nextflow/examples'

    input:
    path 'input.fasta' from params.file

    output:
    path 'seq_*' into records

    """
    awk '/^>/{f="seq_"++d} {print > f}' < input.fasta
    """
}

/*
 * Simple reverse the sequences
 */
process reverse {
    container 'nextflow/examples'

    input:
    path x from records

    output:
    stdout into result

    """
    cat $x | rev
    """
}

/*
 * print the channel content
 */
result.subscribe { println it }