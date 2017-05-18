FROM openjdk:8-alpine

ENV CONFLUENCE_VERSION=6.2.0 \
    CONFLUENCE_HOME=/var/atlassian/application-data/confluence \
    CONFLUENCE_INSTALL=/opt/atlassian/confluence \
    MYSQL_VERSION=5.1.38 \
    POSTGRES_VERSION=9.4.1212
    
RUN set -x
RUN apk add --no-cache wget
RUN apk add --no-cache libressl 
RUN apk add --no-cache tar

RUN mkdir -p "${CONFLUENCE_HOME}"
RUN mkdir -p "${CONFLUENCE_INSTALL}/conf"

RUN wget -O "atlassian-confluence-${CONFLUENCE_VERSION}.tar.gz" --no-verbose "https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-${CONFLUENCE_VERSION}.tar.gz"
RUN wget -O "mysql-connector-java-${MYSQL_VERSION}.tar.gz" --no-verbose "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_VERSION}.tar.gz"
RUN wget -O "postgresql-${POSTGRES_VERSION}.jar" "https://jdbc.postgresql.org/download/postgresql-${POSTGRES_VERSION}.jar"

RUN tar -xzvf "atlassian-confluence-${CONFLUENCE_VERSION}.tar.gz" -C "${CONFLUENCE_INSTALL}" --strip-components=1
RUN tar -xzvf "mysql-connector-java-${MYSQL_VERSION}.tar.gz" -C "${CONFLUENCE_INSTALL}/confluence/WEB-INF/lib" --strip-components=1
RUN mv "postgresql-${POSTGRES_VERSION}.jar" "${CONFLUENCE_INSTALL}/confluence/WEB-INF/lib/postgresql-${POSTGRES_VERSION}.jar"

RUN adduser -D -u 1000 confluence
RUN chown -R confluence "${CONFLUENCE_HOME}"
RUN chown -R confluence "${CONFLUENCE_INSTALL}/conf"
RUN chown -R confluence "${CONFLUENCE_INSTALL}/logs"
RUN chown -R confluence "${CONFLUENCE_INSTALL}/temp"
RUN chown -R confluence "${CONFLUENCE_INSTALL}/work"
RUN chmod -R 700 "${CONFLUENCE_HOME}"
RUN chmod -R 700 "${CONFLUENCE_INSTALL}/conf"
RUN chmod -R 700 "${CONFLUENCE_INSTALL}/logs"
RUN chmod -R 700 "${CONFLUENCE_INSTALL}/temp"
RUN chmod -R 700 "${CONFLUENCE_INSTALL}/work"

RUN echo -e "\nconfluence.home=${CONFLUENCE_HOME}" >> "${CONFLUENCE_INSTALL}/confluence/WEB-INF/classes/confluence-init.properties"

# Expose default HTTP connector ports 
EXPOSE 8090 8091

# Create the volumes and mount
VOLUME ["${CONFLUENCE_HOME}"]

WORKDIR ${CONFLUENCE_INSTALL}

USER confluence
CMD ["sh", "-c", "${CONFLUENCE_INSTALL}/bin/catalina.sh run"]

