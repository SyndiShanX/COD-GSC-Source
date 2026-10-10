/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_callouts.gsc
***************************************************/

#using scripts\engine\utility;
#namespace br_callouts;

function init() {
  level.calloutglobals.namelocations = [];

  if(!istrue(level.calloutglobals.var_41e0068712e63739) && !isDefined(level.calloutglobals.calloutlist) && (!isDefined(level.calloutglobals.callouttable) || !tableexists(level.calloutglobals.callouttable))) {
    return;
  }

  minx = level.mapcorners[0].origin[0];
  maxx = level.mapcorners[1].origin[0];
  sizex = maxx - minx;
  miny = level.mapcorners[0].origin[1];
  maxy = level.mapcorners[1].origin[1];
  sizey = maxy - miny;

  if(istrue(level.calloutglobals.var_41e0068712e63739)) {
    level.calloutglobals.var_81bcc3f4c201eb = [];
    sitecount = function_c3d63e6778e39f83(1);

    for(siteidx = 0; siteidx < sitecount; siteidx++) {
      site = function_d0ed84c86e823a7c(1, siteidx);
      region = function_7fdd7f9d54666e5f(1, site.region);
      ref = region.name + " site_" + siteidx;
      assertex(!isDefined(level.calloutglobals.namelocations[ref]), "<dev string:x1c>" + ref + "<dev string:x2d>" + level.mapname);
      namedlocation = spawnStruct();
      namedlocation.origin = site.origin;
      level.calloutglobals.namelocations[ref] = namedlocation;
      level.calloutglobals.var_81bcc3f4c201eb[siteidx] = ref;
    }

    return;
  }

  if(isDefined(level.calloutglobals.calloutlist)) {
    foreach(callout in level.calloutglobals.calloutlist) {
      if(!istrue(callout.var_c13986eca25dd35e)) {
        continue;
      }

      x = callout.xfrac;
      x = float(x);
      x = x * sizex + minx;
      y = callout.yfrac;
      y = float(y);
      y = y * sizey + miny;
      radius = callout.radius;
      radius = float(radius);
      ref = callout.calloutref;
      namedlocation = spawnStruct();
      namedlocation.origin = (x, y, 0);
      namedlocation.radius = radius;
      level.calloutglobals.namelocations[ref] = namedlocation;
    }

    return;
  }

  for(row = 0; true; row++) {
    var_c13986eca25dd35e = tablelookupbyrow(level.calloutglobals.callouttable, row, 5);

    if(!isDefined(var_c13986eca25dd35e) || var_c13986eca25dd35e == "") {
      break;
    }

    if(var_c13986eca25dd35e != "1") {
      continue;
    }

    x = tablelookupbyrow(level.calloutglobals.callouttable, row, 6);
    x = float(x);
    x = x * sizex + minx;
    y = tablelookupbyrow(level.calloutglobals.callouttable, row, 7);
    y = float(y);
    y = y * sizey + miny;
    radius = tablelookupbyrow(level.calloutglobals.callouttable, row, 8);
    radius = float(radius);
    ref = tablelookupbyrow(level.calloutglobals.callouttable, row, 1);
    namedlocation = spawnStruct();
    namedlocation.origin = (x, y, 0);
    namedlocation.radius = radius;
    level.calloutglobals.namelocations[ref] = namedlocation;
  }
}

function getlocationnameforpoint(point) {
  locname = "";

  if(istrue(level.calloutglobals.var_41e0068712e63739)) {
    siteidx = function_3db4b97c31efed0b(1, point);

    if(isDefined(siteidx)) {
      locname = level.calloutglobals.var_81bcc3f4c201eb[siteidx];
    }
  } else {
    foreach(name, info in level.calloutglobals.namelocations) {
      if(distance2dsquared(point, info.origin) <= info.radius * info.radius) {
        locname = name;
        break;
      }
    }
  }

  return locname;
}

function private function_758c08865c2c0b() {
  if(istrue(level.calloutglobals.var_41e0068712e63739)) {
    function_ca53c186276d760(0, 1);
    return;
  }

  foreach(ref, loc in level.calloutglobals.namelocations) {
    scripts\engine\utility::draw_circle(loc.origin, loc.radius, (1, 1, 0), 1, 0, 1);
    debugstar(loc.origin, (1, 1, 0), 1, ref, 1);
  }
}

function private function_59ff91039ae7cc92() {
  showtablets = isDefined(level.questinfo) && isDefined(level.questinfo.debuginfo) && isDefined(level.questinfo.debuginfo.locationtablets);

  foreach(ref, loc in level.calloutglobals.namelocations) {
    if(showtablets && isDefined(level.questinfo.debuginfo.locationtablets[ref])) {
      foreach(tablet in level.questinfo.debuginfo.locationtablets[ref]) {
        sphere(tablet.origin, 30, (1, 0, 0));
        line(tablet.origin, loc.origin, (1, 0, 0));
      }
    }
  }
}

function function_1d1637db14bbc7d1() {
  if(istrue(level.var_d55be984182fdc3)) {
    level.var_d55be984182fdc3 = 0;
    level notify("<dev string:x48>");
    return;
  }

  level endon("<dev string:x48>");
  level.var_d55be984182fdc3 = 1;

  while(true) {
    function_758c08865c2c0b();
    function_59ff91039ae7cc92();
    waitframe();
  }
}

# /