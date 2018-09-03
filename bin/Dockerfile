FROM java:8
ARG artifactId
ARG version
ENV artifactId=${artifactId}
ENV version=${version}
COPY target/${artifactId}-${version}.jar ${artifactId}-${version}.jar
ENTRYPOINT java -jar ${artifactId}-${version}.jar
