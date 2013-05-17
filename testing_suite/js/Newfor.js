var Newfor, WEB_SOCKET_DEBUG, channel, pusher;
Newfor = {};
Newfor = (function() {
  function Newfor() {}
  return Newfor;
})();
Newfor.parseText = function(line) {
  var l, str, _i, _len, _ref;
  str = [];
  _ref = line.content;
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    l = _ref[_i];
    str.push(l.txt);
  }
  return str.join("");
};
Newfor.twoTineScroll = function(rows) {
  var row, _i, _len, _results;
  _results = [];
  for (_i = 0, _len = rows.length; _i < _len; _i++) {
    row = rows[_i];
    _results.push($("div#line" + row.bloffset).text(Newfor.parseText(row)));
  }
  return _results;
};
Newfor.clearScroll = function() {
  return $('div#scroll-subs > div').each(function() {
    return this.innerText = '';
  });
};
Newfor.currentTextAsBlock = function(rows) {
  var con, line, row, text, _i, _j, _len, _len2, _ref;
  text = [];
  for (_i = 0, _len = rows.length; _i < _len; _i++) {
    row = rows[_i];
    line = [];
    _ref = row.content;
    for (_j = 0, _len2 = _ref.length; _j < _len2; _j++) {
      con = _ref[_j];
      line.push(con.txt);
    }
    text.push(line.join(""));
  }
  return text.join("<br>");
};
Pusher.log = function(message) {
  if (window.console && window.console.log) {
    return window.console.log(message);
  }
};
WEB_SOCKET_DEBUG = true;
pusher = new Pusher('8b830351dbd51ae41414');
channel = pusher.subscribe('live1');
pusher.connection.bind('state_change', function() {
  return $('div#status').text(pusher.connection.state);
});
pusher.connection.bind('connected', function() {
  return $('div#connected').text("true");
});
pusher.connection.bind('unavailable', function() {
  return $('div#connected').text("false");
});
channel.bind('new_subt', function(data) {
  var obj, subt_obj;
  obj = JSON.stringify(data);
  $('div#json').text(obj);
  subt_obj = data.subt;
  $('div#code').text(subt_obj.code);
  $('div#timestamp').text(subt_obj.timestamp);
  if (subt_obj.code === "build") {
    $('div#current-text-as-block').html(Newfor.currentTextAsBlock(subt_obj.row));
    Newfor.twoTineScroll(subt_obj.row);
  }
  if (subt_obj.code === "clear") {
    return Newfor.clearScroll();
  }
});