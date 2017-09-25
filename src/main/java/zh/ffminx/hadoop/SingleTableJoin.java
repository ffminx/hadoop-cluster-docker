package zh.ffminx.hadoop;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author fengmin.xu E-mail: fengmin.xu@56qq.com
 * @since 2017-09-18 15:47
 */
public class SingleTableJoin {

    public static int time = 0;

    public static class MyMapper extends Mapper<Object, Text, Text, Text> {

        public void map(Object key, Text value, Context context) throws IOException, InterruptedException {
            // 左右表的标识
            int relation;
            String[] str = value.toString().split(" ");
            String child = str[0];
            String parent = str[1];
            if (child.compareTo("child") != 0) {
                // 左表
                relation = 1;
                context.write(new Text(parent),
                        new Text(relation + "+" + child));
                // 右表
                relation = 2;
                context.write(new Text(child),
                        new Text(relation + "+" + parent));
            }
        }
    }

    public static class MyReducer extends Reducer<Text, Text, Text, Text> {

        public void reduce(Text key, Iterable<Text> values, Context context) throws IOException, InterruptedException {
            int grandchildnum = 0;
            int grandparentnum = 0;
            List<String> grandchilds = new ArrayList<String>();
            List<String> grandparents = new ArrayList<String>();

            /** 输出表头 */
            if (time == 0) {
                context.write(new Text("grandchild"), new Text("grandparent"));
                time++;
            }
            for (Text val : values) {
                String record = val.toString();
                char relation = record.charAt(0);
                // 取出此时key所对应的child
                if (relation == '1') {
                    String child = record.substring(2);
                    grandchilds.add(child);
                    grandchildnum++;
                }
                // 取出此时key所对应的parent
                else {
                    String parent = record.substring(2);
                    grandparents.add(parent);
                    grandparentnum++;
                }
            }
            if (grandchildnum != 0 && grandparentnum != 0) {
                for (int i = 0; i < grandchildnum; i++) {
                    for (int j = 0; j < grandparentnum; j++) {
                        context.write(new Text(grandchilds.get(i)), new Text(
                                grandparents.get(j)));
                    }
                }
            }

        }

    }

    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
        if (otherArgs.length < 2) {
            System.err.println("Usage: single table join <in> [<in>...] <out>");
            System.exit(2);
        }
        Job job = Job.getInstance(conf, "single table join");
        job.setJarByClass(SingleTableJoin.class);
        job.setMapperClass(MyMapper.class);
        job.setReducerClass(MyReducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);
        for (int i = 0; i < otherArgs.length - 1; ++i) {
            FileInputFormat.addInputPath(job, new Path(otherArgs[i]));
        }
        FileOutputFormat.setOutputPath(job,
                new Path(otherArgs[otherArgs.length - 1]));
        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
}

