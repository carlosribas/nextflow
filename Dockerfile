FROM nextflow/nextflow
RUN apk --update add postgresql-client
RUN mkdir /code
WORKDIR /code
COPY . /code/
RUN chmod 744 /code/run_example_pipeline.sh
ENTRYPOINT ["bash", "run_example_pipeline.sh"]