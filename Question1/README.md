# Build Instructions
### Requirements
* Java 8
* Have your `JAVA_HOME` environment variable set to your java SDK (`C:\Program Files\Java\jdk1.8.0_131` for example)
* And obviously set `%JAVA_HOME%\bin` in your `Path` (like this you can run java commands)
 
### Building
1. `cd Question1` (if you haven't already)
2. Compile with the given maven wrapper: 
   * `./mvnw clean package` (for UNIX) or 
   * `mvnw.cmd clean package` (for WINDOWS)
3. Once done, run: `java -jar .\target\com.question1-1.0-SNAPSHOT.jar`
