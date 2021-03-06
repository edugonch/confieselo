module TagsHelper
  def tag_cloud(tags, classes)
    map = %Q{
      function() {
        if(this.confesion_ids){
          emit(this.name, {count: this.confesion_ids.length})
        }
      }
    }

    reduce = %Q{
      function(keys, values){
        var result = 0
        values.forEach(function(value) {
          result += value.count;
        });
        return result;
      }
    }
    max_arr = []
    tags.map_reduce(map, reduce).out(inline: 1).each do |count|
      max_arr << count["value"]
    end
    max = max_arr.sort_by{ |obj| obj["count"]}.last
    tags.each do |tag|
      index = tag.confesions.count.to_f / max["count"] * (classes.size - 1)
      font = tag.confesions.count.to_f / max["count"] * 40
      font = 9 if font < 9
      yield(tag, classes[index.round], font)
    end
  end
  def tags_list(tags)
    html = ''
    tags.each do |tag|
      html << "<a href='#{tag_path(tag)}'><span class='label label-primary'>#{tag.name}</span></a> "
    end
    html
  end
end
