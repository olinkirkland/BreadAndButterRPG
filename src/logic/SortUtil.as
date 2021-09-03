package logic
{
    import spark.collections.Sort;
    import spark.collections.SortField;

    public class SortUtil
    {
        public static function get byTime():Sort
        {
            var sort:Sort = new Sort();
            sort.fields = [new SortField("time", true)];
            return sort;
        }
    }
}
