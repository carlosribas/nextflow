FROM nextflow/nextflow
RUN mkdir /code
WORKDIR /code
COPY . /code/
ENTRYPOINT ["bash", "run_example_pipeline.sh"]