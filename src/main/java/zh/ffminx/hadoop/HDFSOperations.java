package zh.ffminx.hadoop;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.LocatedFileStatus;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.fs.RemoteIterator;

import java.io.IOException;
import java.net.URI;

/**
 * @author fengmin.xu E-mail: fengmin.xu@56qq.com
 * @since 2017-09-18 16:01
 */
public class HDFSOperations {

    FileSystem fileSystem;

    public void configure() throws Exception {
        Configuration configuration = new Configuration();
        configuration.set("fs.defaultFS", "hdfs://localhost:9000");
        fileSystem = FileSystem.get(URI.create("hdfs://localhost:9000"), configuration, "root");
    }

    public void listFiles(String strPath) throws IOException {
        Path path = new Path(strPath);
        RemoteIterator<LocatedFileStatus> iterator = fileSystem.listFiles(path, true);

        while (iterator.hasNext()) {
            LocatedFileStatus status = iterator.next();
            System.out.println(status.getPath().getName());
        }
    }

    public void rm() throws IOException {
        Path path = new Path("/");
        fileSystem.delete(path, true);
    }

    public void mkdir() throws IOException {
        Path path = new Path("/demo");
        fileSystem.mkdirs(path);
    }

    public static void main(String[] args) throws Exception {
        HDFSOperations hdfsOperations = new HDFSOperations();
        hdfsOperations.configure();
        hdfsOperations.mkdir();
        hdfsOperations.listFiles("/demo");
    }

}
