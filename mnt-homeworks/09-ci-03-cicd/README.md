# Домашнее задание к занятию 9 «Процессы CI/CD»
## Знакомоство с SonarQube
  ### Основная часть
 9. Сделайте скриншот успешного прохождения анализа, приложите к решению ДЗ.
<p>
  <img   src='https://github.com/gemeral68/devops_netology/blob/main/mnt-homeworks/09-ci-03-cicd/sonar1.png' width='490' hspace="5">
  <img   src='https://github.com/gemeral68/devops_netology/blob/main/mnt-homeworks/09-ci-03-cicd/sonar2.png' width='490' hspace="5">
</p>

## Знакомство с Nexus
### Основная часть
4. В ответе пришлите файл maven-metadata.xml для этого артефекта.

<img align="right" src='https://github.com/gemeral68/devops_netology/blob/main/mnt-homeworks/09-ci-03-cicd/maven.png' width='470' hspace="5" alt="image" />

    <?xml version="1.0" encoding="UTF-8"?>
    <metadata modelVersion="1.1.0">
      <groupId>netology</groupId>
      <artifactId>java</artifactId>
      <versioning>
        <latest>8_102</latest>
        <release>8_102</release>
        <versions>
          <version>8_102</version>
        </versions>
        <lastUpdated>20231113120623</lastUpdated>
      </versioning>
    </metadata>

  
## Знакомство с Maven
### Основная часть

4. В ответе пришлите исправленный файл pom.xml.
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>netology</groupId>
  <artifactId>java</artifactId>
  <version>8_282</version>
   <repositories>
    <repository>
      <id>my-repo</id>
      <name>maven-public</name>
      <url>http://localhost:8081/repository/maven-public/</url>
    </repository>
  </repositories>
  <dependencies>
<!--     <dependency>
               <groupId>somegroup</groupId>
      <artifactId>someart</artifactId>
      <version>somevers</version>
      <classifier>someclass</classifier>
      <type>sometype</type>
    </dependency> -->
  </dependencies>
</project>
```
  
