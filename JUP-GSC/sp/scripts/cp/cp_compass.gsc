/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_compass.gsc
***********************************************/

#using scripts\cp\cp_compass;
#using scripts\cp_mp\utility\game_utility;
#namespace cp_compass;

function setupminimap(material, numtiles, force) {
  if(!isDefined(force)) {
    force = 0;
  }

  requiredmapaspectratio = getdvarfloat(@ "scr_requiredmapaspectratio", 1);

  if(istrue(force) && !isDefined(material)) {
    material = "<dev string:x1c>";
  }

  corners = [];
  allcorners = getEntArray("minimap_corner", "targetname");

  if(istrue(force) && allcorners.size < 1) {
    allcorners[0] = spawn("<dev string:x30>", (16384, 16384, 0));
    allcorners[1] = spawn("<dev string:x30>", (-16384, -16384, 0));
  }

  if(allcorners.size < 1) {
    return;
  }

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    corners = getcornersfromarray(allcorners, 1);

    if(corners.size != 2) {
      corners = getcornersfromarray(allcorners, 0);
    }
  } else {
    corners = [allcorners[0], allcorners[1]];
  }

  mapname = getDvar(@ "ui_mapname");

  switch (mapname) {
    case #"hash_38a9f093178c79ea":
      break;
    case #"hash_c1ef755c94d4e844":
      break;
    case #"hash_1830577c7baa1362":
      corners[0].origin = (-65536, 86016, 0);
      corners[1].origin = (81920, -61440, 0);
      break;
    case #"hash_d20f85c13b46eab3":
      corners[0].origin = (44048, -32792, -152);
      corners[1].origin = (-1008, 12264, -152);
      break;
    case #"hash_a810885500a2bb04":
      corners[0].origin = (-33792, 23552, 0);
      corners[1].origin = (-2048, -8192, 0);
      break;
    case #"hash_426306a94e24e290":
      corners[0].origin = (-49152, -24576, 0);
      corners[1].origin = (16384, 40960, 0);
      break;
    case #"hash_7344128ff773082f":
      corners[0].origin = (-24576, 65536, 0);
      corners[1].origin = (45056, -4096, 0);
      break;
    case #"hash_974d9df6113f246":
      corners[0].origin = (14336, 53248, 0);
      corners[1].origin = (47104, 20480, 0);
      break;
    case #"hash_ce10256a09df8f35":
      corners[0].origin = (4096, 24576, 0);
      corners[1].origin = (49152, -20480, 0);
      break;
    case #"hash_5ecfbef1b5de6c84":
      corners[0].origin = (-12288, 72704, 0);
      corners[1].origin = (32768, 27648, 0);
      break;
    case #"hash_4eb88e4b4b17d1e8":
      var_685b0d8afd1764dc = [allcorners[0], allcorners[1]];
      var_685b0d8afd1764dc[0].origin = (-2620, 8092, 0);
      var_685b0d8afd1764dc[1].origin = (3156, 3486, 0);
      setupminimapmaze("compass_map_cp_jugg_maze", var_685b0d8afd1764dc, requiredmapaspectratio);
      corners[0].origin = (-5508, 10395, 0);
      corners[1].origin = (6044, 1183, 0);
      break;
    case #"hash_e7978e13d7ba3321":
      corners[0].origin = (-57344, 16384, 0);
      corners[1].origin = (0, -49152, 0);
      break;
    case #"hash_c3c819184bc33817":
    case #"hash_ddd09c6970ff6bef":
      corners[0].origin = (-11784, 15676, 0);
      corners[1].origin = (7916, 35376, 4092);
      break;
  }

  corner0 = (corners[0].origin[0], corners[0].origin[1], 0);
  corner1 = (corners[1].origin[0], corners[1].origin[1], 0);
  cornerdiff = corner1 - corner0;
  epsilon = 0.001;
  var_317644a421923e18 = cos(getnorthyaw());

  if(abs(var_317644a421923e18) < epsilon) {
    var_317644a421923e18 = 0;
  }

  if(abs(var_317644a421923e18 - 1) < epsilon) {
    var_317644a421923e18 = 1;
  }

  if(abs(var_317644a421923e18 + 1) < epsilon) {
    var_317644a421923e18 = -1;
  }

  var_317645a42192404b = sin(getnorthyaw());

  if(abs(var_317645a42192404b) < epsilon) {
    var_317645a42192404b = 0;
  }

  if(abs(var_317645a42192404b - 1) < epsilon) {
    var_317645a42192404b = 1;
  }

  if(abs(var_317645a42192404b + 1) < epsilon) {
    var_317645a42192404b = -1;
  }

  north = (var_317644a421923e18, var_317645a42192404b, 0);
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

function function_ca4665b0582ee426(var_cd27fd453a6003ce) {
  min_floor = var_cd27fd453a6003ce[0].script_floor_number;
  max_floor = var_cd27fd453a6003ce[0].script_floor_number;

  foreach(floor_trigger in var_cd27fd453a6003ce) {
    floor = floor_trigger.script_floor_number;

    if(floor < min_floor) {
      min_floor = floor;
      continue;
    }

    if(floor > max_floor) {
      max_floor = floor;
    }
  }

  self.var_109a3bfd035f27be = 0;
  self.var_7f574731fa72c7af = 0;
  self setclientomnvar("ui_minimap_min_floor", min_floor);
  self setclientomnvar("ui_minimap_max_floor", max_floor);
  thread function_50e3344114aedeee();
}

function function_fb7bad834ce4b28c(floornumber) {
  self setclientomnvar("ui_minimap_floor", floornumber);
  map_name = tolower(getDvar(@ "ui_mapname"));
  minimap_image = "compass_map_" + map_name + "_floor_" + floornumber;
  self.var_109a3bfd035f27be = floornumber;
  scripts\cp\cp_compass::setupminimap(minimap_image);
}

function function_50e3344114aedeee() {
  for(;;) {
    self waittill("luinotifyserver", channel, value);

    if(channel == "minimap_floor_switch") {
      switch (value) {
        case 1:
          function_fb7bad834ce4b28c(self.var_109a3bfd035f27be + 1);
          break;
        case 4294967295:
          function_fb7bad834ce4b28c(self.var_109a3bfd035f27be - 1);
          break;
        case 0:
          function_fb7bad834ce4b28c(self.var_7f574731fa72c7af);
          break;
      }
    }
  }
}

function setupminimapmaze(material, corners, requiredmapaspectratio) {
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

  setminimapcpraidmaze(material, northwest[0], northwest[1], southeast[0], southeast[1]);
}

function vecscale(vec, scalar) {
  return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}

function getcornersfromarray(array, uselocale) {
  corners = [];

  if(uselocale) {
    foreach(corner in array) {
      if(isDefined(corner.script_noteworthy) && corner.script_noteworthy == level.localeid) {
        corners[corners.size] = corner;
      }
    }
  } else {
    foreach(corner in array) {
      if(!isDefined(corner.script_noteworthy) || isDefined(corner.script_noteworthy) && !issubstr(corner.script_noteworthy, "locale")) {
        corners[corners.size] = corner;
      }
    }
  }

  return corners;
}