/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_49cab767cb5cdf73.gsc
*****************************************************/

#using scripts\engine\hud_management;
#namespace compass;

function function_5902442acc925c54(material, numtiles, uselocale) {
  requiredmapaspectratio = getdvarfloat(@ "scr_requiredmapaspectratio", 1);
  corners = [];
  allcorners = getEntArray("-!\x168\xc7\xd3\x01\xdd@\xf3pv\xb1u", #targetname);

  if(!isDefined(uselocale)) {
    uselocale = 0;
  }

  corners = getcornersfromarray(allcorners, uselocale);

  if(corners.size != 2) {
    println("<dev string:x24>");
    return;
  }

  corner0 = (corners[0].origin[0], corners[0].origin[1], 0);
  corner1 = (corners[1].origin[0], corners[1].origin[1], 0);
  cornerdiff = corner1 - corner0;
  north = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  west = (0 - north[1], north[0], 0);

  if(vectordot(cornerdiff, west) > 0) {
    if(vectordot(cornerdiff, north) > 0) {
      northwest = corner1;
      southeast = corner0;
    } else {
      side = vecscale(north, vectordot(cornerdiff, north));
      northwest = corner1 - side;
      southeast = corner0 + side;
    }
  } else if(vectordot(cornerdiff, north) > 0) {
    side = vecscale(north, vectordot(cornerdiff, north));
    northwest = corner0 + side;
    southeast = corner1 - side;
  } else {
    northwest = corner0;
    southeast = corner1;
  }

  if(requiredmapaspectratio > 0) {
    northportion = vectordot(northwest - southeast, north);
    westportion = vectordot(northwest - southeast, west);
    mapaspectratio = westportion / northportion;

    if(mapaspectratio < requiredmapaspectratio) {
      incr = requiredmapaspectratio / mapaspectratio;
      addvec = vecscale(west, westportion * (incr - 1) * 0.5);
    } else {
      incr = mapaspectratio / requiredmapaspectratio;
      addvec = vecscale(north, northportion * (incr - 1) * 0.5);
    }

    northwest += addvec;
    southeast -= addvec;
  }

  corners[0].origin = northwest;
  corners[1].origin = southeast;
  level.mapsize = vectordot(northwest - southeast, north);
  level.mapcorners = corners;
  level.mapcorners[0].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[1].origin - level.mapcorners[0].origin), (0, 0, 1));
  level.mapcorners[0] addyaw(45);
  level.mapcorners[1].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[0].origin - level.mapcorners[1].origin), (0, 0, 1));
  level.mapcorners[1] addyaw(45);

  if(!isDefined(numtiles) || numtiles < 1) {
    numtiles = 1;
  }

  setminimap(material, northwest[0], northwest[1], southeast[0], southeast[1], numtiles);
}

function compass_open(scripted_widget, x, y, horizontal_anchor, vertical_anchor, map_alpha, draw_player, draw_others, draw_items, draw_loc_select_cursor, draw_player_ping, draw_radar_sweep, compass_type, bounds_radius, large_map) {
  if(!isDefined(scripted_widget)) {
    scripted_widget = "\xaf6MJd\x0egy\x9e\xf9\a4\x87\xec\x01\xfd\xb8\xf1\x01\xd8Gx\xf2";
  }

  if(!isDefined(x)) {
    x = 100;
  }

  if(!isDefined(y)) {
    y = 100;
  }

  if(!isDefined(horizontal_anchor)) {
    horizontal_anchor = 0;
  }

  if(!isDefined(vertical_anchor)) {
    vertical_anchor = 0;
  }

  if(!isDefined(map_alpha)) {
    map_alpha = 0.75;
  }

  if(!isDefined(draw_player)) {
    draw_player = 1;
  }

  if(!isDefined(draw_others)) {
    draw_others = 1;
  }

  if(!isDefined(draw_items)) {
    draw_items = 1;
  }

  if(!isDefined(draw_loc_select_cursor)) {
    draw_loc_select_cursor = 0;
  }

  if(!isDefined(draw_player_ping)) {
    draw_player_ping = 0;
  }

  if(!isDefined(draw_radar_sweep)) {
    draw_radar_sweep = 1;
  }

  if(!isDefined(compass_type)) {
    compass_type = 0;
  }

  if(!isDefined(bounds_radius)) {
    bounds_radius = 0.975;
  }

  if(!isDefined(large_map)) {
    large_map = 0;
  }

  fields = [];
  fields["\xf8\xd1=A\x93\xa0qq\xcc"] = map_alpha;
  fields["\x84\x94p\x8a\xe6)e\x18Abt"] = draw_player;
  fields["c\xe2+\xf9\x0fn_\xe3\x98\x10\x1f"] = draw_others;
  fields["\x8d\x9b\xd1T\x04\xf2\x1fAE\x01"] = draw_items;
  fields["\x17\xeb[-dNKz\x88\xf8\xb2x5 \x83 \xcaC$\xf4\xec\x97"] = draw_loc_select_cursor;
  fields["\x9dL\xbc\xb0K\x18}'\xe75\x18E\x88\xf3\x90\xfd"] = draw_player_ping;
  fields["\x19\xe4,\xbb}'\xb0\x8c,\xc9}\x9bwV\x958"] = draw_radar_sweep;
  fields["\x88\xe4\x0fF\x80\x9bt>\x964\x94\xff"] = compass_type;
  fields["\xa7\x05\xbb\xea\xc5\xdf~o\xb8\x19\x99\xe2\x83"] = bounds_radius;
  fields["@7\xab\x90e\xbb\f\xa3."] = large_map;
  hud_management::function_35924dfcb78711f4("\xde\xda\xdb|\xdc\xf6\xa6?[\x92\xcc\xac:\xc3\xe4", scripted_widget);
  hud_management::function_41ff479ac45608d6("\xde\xda\xdb|\xdc\xf6\xa6?[\x92\xcc\xac:\xc3\xe4", fields, 1);
  hud_management::function_85d8a0ba2e35b6f2("\xde\xda\xdb|\xdc\xf6\xa6?[\x92\xcc\xac:\xc3\xe4", x, y, horizontal_anchor, vertical_anchor);
}

function compass_close() {
  hud_management::scripted_widget_destroy("\xde\xda\xdb|\xdc\xf6\xa6?[\x92\xcc\xac:\xc3\xe4");
}

function private vecscale(vec, scalar) {
  return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}

function private getcornersfromarray(array, uselocale) {
  corners = [];

  if(uselocale) {
    foreach(corner in array) {
      if(isDefined(corner.script_noteworthy) && corner.script_noteworthy == level.localeid) {
        corners[corners.size] = corner;
      }
    }
  } else {
    foreach(corner in array) {
      if(!isDefined(corner.script_noteworthy) || isDefined(corner.script_noteworthy) && !issubstr(corner.script_noteworthy, "s(\x87n\xb5\xc0")) {
        corners[corners.size] = corner;
      }
    }
  }

  return corners;
}