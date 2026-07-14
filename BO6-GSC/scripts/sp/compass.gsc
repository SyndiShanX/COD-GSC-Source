/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\compass.gsc
**************************************/

#namespace compass;

function setupminimap(material, corner_targetname, numtiles) {
  if(!isDefined(material)) {
    material = "";
  }

  level.minimap_image = material;

  if(!isDefined(corner_targetname)) {
    corner_targetname = "-!\x168\xc7\xd3\x01\xdd@\xf3pv\xb1u";
  }

  requiredmapaspectratio = getdvarfloat(@ "scr_requiredmapaspectratio", 1);
  corners = getEntArray(corner_targetname, #targetname);

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

  level.map_extents = [];
  level.map_extents["\x1d Q"] = northwest[1];
  level.map_extents["=\xff0b"] = southeast[0];
  level.map_extents["\x14#\x01\x89\f\x81"] = southeast[1];
  level.map_extents["o0\xee\xc1\x8c"] = northwest[0];
  level.map_width = level.map_extents["o0\xee\xc1\x8c"] - level.map_extents["=\xff0b"];
  level.map_height = level.map_extents["\x1d Q"] - level.map_extents["\x14#\x01\x89\f\x81"];
  level.mapsize = vectordot(northwest - southeast, north);

  if(!isDefined(numtiles) || numtiles < 1) {
    numtiles = 1;
  }

  setminimap(material, northwest[0], northwest[1], southeast[0], southeast[1], numtiles);
}

function vecscale(vec, scalar) {
  return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}