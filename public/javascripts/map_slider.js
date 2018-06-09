function getElectionYear(name) {
    var matches = name.match(/\d\d\d\d/);
    if (matches != null) {
        return parseInt(matches[0]);
    } else {
        return '';
    }
}

function showLegend(year) {
    if (year < 1962) {
        $("#legend-1958").show();
        $("#legend-1962,#legend-1973").hide();
    } else if (year < 1973) {
        $("#legend-1962").show();
        $("#legend-1973,#legend-1958").hide();
    } else {
        $("#legend-1973").show();
        $("#legend-1962,#legend-1958").hide();
    }
 
}

$(document).ready(function() {
    var image_path = '/images/historic_maps/';
    var election_years = [2011, 2007, 2003, 1999, 1995, 1990, 1988, 1986, 1981, 1977, 1973, 1969, 1966, 1962, 1959, 1958]
    var images = {}
    var legends = {}

    for (var i = 0; i < election_years.length; i++) {
        var year = election_years[i];
        var img = document.createElement('img');
        img.src = image_path + 'Manitoba-' + year + '.png';
        $(img).attr("id", "image-" + year);
        $(img).attr("class","hmap");
        if (i == 0) {
            $("#election-title").html("Election Results in " + year );
        } else {
            $(img).hide();
        }
        $('#image-frame').prepend(img);
        images[year] = img;
    }

    var changed_year = function() { 
        var clicked = $(this);
        $('a',ul).css('font-weight','normal');
        clicked.css('font-weight','bold');

        requested_year = getElectionYear(clicked.html());
        $("#election-title").html("Election Results in " + requested_year );

        $('.hmap').hide();
        $(images[requested_year]).show();

        showLegend(requested_year);

        return false;
    }

    var nav = $('#nav');
    var ul  = $('<ul>');
    nav.append(ul);
    for (i in images) {
        var link = $('<a href="#">' + i + '</a>');
        $(ul).prepend($('<li>').append(link));
        link.hover(changed_year);
        link.click(changed_year); // For tablets
    }
   
});

//$(document).ready(function() {
    //var image_path = '/images/historic_maps/';
    //var images = [
       //'Manitoba-1958.png',
       //'Manitoba-1959.png',
       //'Manitoba-1962.png',
       //'Manitoba-1966.png',
       //'Manitoba-1969.png',
       //'Manitoba-1973.png',
       //'Manitoba-1977.png',
       //'Manitoba-1981.png',
       //'Manitoba-1986.png',
       //'Manitoba-1988.png',
       //'Manitoba-1990.png',
       //'Manitoba-1995.png',
       //'Manitoba-1999.png',
       //'Manitoba-2003.png',
       //'Manitoba-2007.png'
                  //];
    //var i=0;
    //for (var elem in images) {
        //if (images.hasOwnProperty(elem)) {
            //var img = document.createElement('img');
            //img.src = image_path + images[elem];
            //$(img).attr("id", "image-" + i);
            //$(img).attr("class","hmap");
            //if (i == 0) {
                //$(img).css('z-index',1);
                //$("#election-title").html("Election Results in " + getElectionYear(images[i]));
            //} else {
                //$(img).css('z-index',0);
            //}
            //$('#image-frame').prepend(img);
        //}
        //i++;
    //}
    //$('#slider').slider({
        //animate: false,
        //min: 0,
        //max: (images.length-1),
        //start: function(event,ui) {
        //},
        //slide: function(event, ui) {
            //$("#image-frame img").each(function() {
                //$(this).css('z-index',0);
            //});
            //var election_year = getElectionYear(images[ui.value]);
            //if (parseInt(election_year,10) < 1962) {
                //$("#legend").attr('src',image_path + "legend_1958.png");
            //} else if (parseInt(election_year,10) < 1973) {
                //$("#legend").attr('src',image_path + "legend_1962.png");
            //} else {
                //$("#legend").attr('src',image_path + "legend_1973.png");
            //}
            //$("#election-title").html("Election in " + election_year);
            //$("#image-" + ui.value).css('z-index',1);
        //}
    //});
    
//});
