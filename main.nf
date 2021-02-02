#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process getNames {
  output:
  path('names')

  """
  psql -c 'SELECT full_descr from rnc_database' '$params.db' > names
  """
}

process splitLetters {
    input:
    val(name)

    output:
    path('chunk_*')

    """
    printf '$name' | split -b 6 - chunk_
    """
}


process convertToUpper {
    input:
    path(x)

    output:
    stdout

    """
    cat $x | tr '[a-z]' '[A-Z]'
    """
}

workflow {
  main:
  getNames | splitCsv | splitLetters | convertToUpper | view { it.trim() }
}