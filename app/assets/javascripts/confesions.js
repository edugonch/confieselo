$(function(){
	var confesion_tags = $('#confesion_tags');
        if(confesion_tags.length > 0) {
            confesion_tags.tagsinput({
                confirmKeys: [13, 188, 44]
            });

            var tags = new Bloodhound({
              datumTokenizer: function(d) { return Bloodhound.tokenizers.whitespace(d.name); },
              queryTokenizer: Bloodhound.tokenizers.whitespace,
              remote: tags_path + "?query=%QUERY"
            });

            tags.initialize();

            confesion_tags.tagsinput('input').typeahead(null, {
              displayKey: 'name',
              source: tags.ttAdapter()
            }).bind('typeahead:selected', $.proxy(function (obj, datum) {
              confesion_tags.tagsinput('add', datum.name);
              this.tagsinput('input').typeahead('val', '');
            }, confesion_tags));
	    }

       $("#confesion_message").wysihtml5({
		"font-styles": false,
		"image": false,
		"locale": "es-ES"	
	});
});
