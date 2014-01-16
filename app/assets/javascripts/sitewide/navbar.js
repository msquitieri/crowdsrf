$(function() {
	console.log("about to bind event");
	$("#tag-search-input").keydown(function(e) {
		// Without the setTimeout, it will grab the value before it is changed.
		setTimeout(function() {
			$tag_input = $("#tag-search-input");
			var val = $tag_input.val();

			if (val.length != 0) {
				// Style as hashtags
	 			val = val.replace(/#/g, '');
	 			val = val.replace(/ /g, '');
				val = "#" + val;

				$tag_input.val(val);
			}
		}, 10);
	});
});