/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\vehicle_interact.gsc
*******************************************/

#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\colors;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_rig;
#namespace vehicle_interact;
#using_animtree("\x17G\x8b^_\xda\xffO\xb6$x");

function init_vehicle_interact() {
  precacheshader("\x86\xbaF\xeb\xa5\x1b\xde\x9b_\xb5\x167\xa36\x95");
  utility::flag_init("\xe06,\xcb\xac\x9c}\xa5\x9b\xd1+N\xb0\xc6\xa3\xa5\xb9\xce\xeb\xce+h\xd2\xd8\x1b\x95");
  level.scr_animtree[">n=\xb1\x10 \x894(h|\xfd8\xfe\x1f\xe0"] = #animtree;
  level.scr_anim[">n=\xb1\x10 \x894(h|\xfd8\xfe\x1f\xe0"]["4\xc7\x7f\x85t9\xc1"] = % \xfe\xc3J\x1d6\x89\xef\x1b\xc0 - \xc3 < 3\xe9\xef\xb09\xce\xa4\xc38z\xeaV2s\x97\x8eJ;
  level.scr_anim[">n=\xb1\x10 \x894(h|\xfd8\xfe\x1f\xe0"]["\xd9&L\xf8Q\x96K"] = % \xc4 > < \x99kh / \xc7\xac\x9dHk\x82\x1c\xb0d\xd7\x7f < \x9f | g\xbd = T\xed\xa4`\x82;
level.scr_anim[ ">n=\xb1\x10 \x894(h|\xfd8\xfe\x1f\xe0" ][ "\xec\x97\xdd=\xe7\xd7\x10" ] = %\xde$\xecU\x02\xde\xacB\xa24A,\x13\xb8{b3\xdew\x19\xfbB\xc6A\xdf\x1d\x85\xbag;
level.scr_anim[ ">n=\xb1\x10 \x894(h|\xfd8\xfe\x1f\xe0" ][ "DIs?\xf0\xad\xe2" ] = %\xa9@\xd0\xceP\xc0\\\xe1\x04U\xe05kd\xb5\xb1r\xce\x05\xbb\xae\xcfBvV\x80\x1d\xc0\x84;
level.scr_anim[ ">n=\xb1\x10 \x894(h|\xfd8\xfe\x1f\xe0" ][ "\v\xd8gB\xd8\xcd0g\xec\xbf" ] = %X\x12\xa5\x88\xcf7\xe7\x8d3\xbf\x1c:H|\x85\x8d\x11!d\a\xf6\xb5tN/=E\x81\xf1|\xc1w;
structs = utility::getStructArray( ">n=\xb1\x10 \x894(h|\xfd8\xfe\x1f\xe0", "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc" );

if( structs.size )
{
thread main_vehicle_interact( structs );
}
}

function main_vehicle_interact( structs )
{
level.interact_vehicle = spawnStruct();
level.interact_vehicle.entries = [];
level.interact_vehicle.g_inuse = 0;
waitframe();

foreach ( struct in structs )
{
level.interact_vehicle.entries[ level.interact_vehicle.entries.size ] = struct;

if( isDefined( struct.target ) )
{
ent = getEnt( struct.target, #targetname );

if( isDefined( ent ) )
{
struct.vehicle = ent;
struct.vehicle useanimtree(#animtree );
}

scriptables = getscriptablearray( struct.target, #targetname );

if( scriptables.size > 0 )
{
struct.vehicle = scriptables[ 0 ];
}
}
else
{
ents = getEntArray( ">n=\xb1\x10 \x894(h|\xfd8\xfe\x1f\xe0", #targetname );
struct.vehicle = utility::getclosest( struct.origin, ents, 0.01 );

if( isDefined( struct.vehicle ) )
{
struct.vehicle useanimtree(#animtree );
}
else
{
scriptables = getscriptablearray( ">n=\xb1\x10 \x894(h|\xfd8\xfe\x1f\xe0", #targetname );
struct.vehicle = utility::getclosest( struct.origin, scriptables, 0.01 );
}
}

assert( isDefined( struct.vehicle ), "<dev string:x24>" + struct.origin );
struct.cover_nodes = [];
doors_avail = utility::getStructArray( struct.script_linkto, "F\x83\x1c\x9d\x19\xc5\xd7\x13;\xb3\x14n\x18\xf5\x13" );

foreach ( door in doors_avail )
{
assert( isDefined( door.script_namenumber ), "<dev string:x70>" );

if( strtok( door.script_namenumber, "\xda" )[ 0 ] == ":\xc9\x93\xe1?" )
{
struct.cover_nodes = utility::array_add( struct.cover_nodes, door );
continue;
}

struct.doors[ strtok( door.script_namenumber, "w" )[ 1 ] ] = door;
struct thread interact_door_setup( door );
}

foreach ( node in struct.cover_nodes )
{
}

if( isDefined( struct.script_animname ) )
{
struct.vehicle.animname = struct.script_animname;
}
else
{
struct.vehicle.animname = ">n=\xb1\x10 \x894(h|\xfd8\xfe\x1f\xe0";
}

struct.dont_lerp_player = 0;
}
}

function interact_door_setup( door )
{
self endon( "\x1e\xfd\xd1\xa2\a" );
level.player endon( "\x1e\xfd\xd1\xa2\a" );

if( !isDefined( self.hint_bones ) )
{
self.hint_bones = [];
bone_count = getnumparts( self.vehicle.model );

for( i = 0; i < bone_count ; i++ )
{
part_name = getpartname( self.vehicle.model, i );

if( !isDefined( level.var_263dbd9fe10b117e ) )
{
level.var_263dbd9fe10b117e = [];
level.var_263dbd9fe10b117e[#"tag_door_lf_hint_outside" ] = "\xb6\xfdx\xdch\x8b\x01u\xb8\x016\xafB7bt#\r\xd8\xd0mK\xc0\xf9";
level.var_263dbd9fe10b117e[#"tag_door_lr_hint_outside" ] = "\xedP_M\x05\xa7\xebPR?\xc6 \xfc\xf8\xad\\\xd1\xbe\xffh\x1a\x17iJ";
level.var_263dbd9fe10b117e[#"tag_door_rf_hint_outside" ] = "e\xae R4&\xb4jA\xf2B\x8f\xa1\x14}e\xd1\x1dlgM~q{";
level.var_263dbd9fe10b117e[#"tag_door_rr_hint_outside" ] = "?\x17\xdf/v$A\xd5\xf9\xfa\x99<\x8fq\x1c\xed\xb3\f>}\xf2\x83\xc2\x17";
level.var_263dbd9fe10b117e[#"tag_trunk_hint_outside" ] = "\xd91\t\xc1j>\x10X\xf2o\xfdmB\xa9$\xd64_\xe5\x85\xe4\x97";
level.var_263dbd9fe10b117e[#"tag_door_lr_hint_inside" ] = "H\x18\xf4\xbd{\x88a\x83\x9d\xfc\x1e\xc5\xee\xa0=\xee\x91-\xf8/O\xd7\xe0";
level.var_263dbd9fe10b117e[#"tag_door_rr_hint_inside" ] = "f\x1d\x89\xef\xecHD\x98\x06@f\xc5Z\xab\x99\xda\xb0(\x12\x02M\x90\xbb";
level.var_263dbd9fe10b117e[#"tag_sunroof_hint_outside" ] = "f\x0f\xfd\xdc\xe9/\xa1Q\x9f\xc3|\x9e\x1e/<\xee#A\x8c\xea{\x05\x15(";
}

if( isDefined( level.var_263dbd9fe10b117e[ part_name ] ) )
{
part_name = level.var_263dbd9fe10b117e[ part_name ];
}
else
{
part_name = "";
}

switch ( part_name )
{
case #"hash_8206852cf7738091":
self.hint_bones[ "\x02\xd83\x19`
  1\xbe\xdf\x10M " ] = "\xb6\xfdx\xdch\x8b\x01u\xb8\x016\xafB7bt #\r\xd8\xd0mK\xc0\xf9 ";
  break;
  case #"hash_516d2d88a3a1cfdd":
    self.hint_bones["X5\xe8\x82\xa6\xd0\\TY\b"] = "\xedP_M\x05\xa7\xebPR?\xc6 \xfc\xf8\xad\\\xd1\xbe\xffh\x1a\x17iJ";
  break;
  case #"hash_fb67cffbd1547fab":
    self.hint_bones["Z\xbe\xd0lw5\x02\x14u6"] = "e\xae R4&\xb4jA\xf2B\x8f\xa1\x14}e\xd1\x1dlgM~q{";
  break;
  case #"hash_912679f637f549df":
    self.hint_bones["\xdb\\\xd9\f&\xcc\xb2~\xc3\xa3"] = "?\x17\xdf/v$A\xd5\xf9\xfa\x99<\x8fq\x1c\xed\xb3\f>}\xf2\x83\xc2\x17";
  break;
  case #"hash_e7ff8660150fa45e":
    self.hint_bones["$\x03VN\x1e\x94i\x8f\x1f\xdc\xf9\xff\x8f"] = "\xd91\t\xc1j>\x10X\xf2o\xfdmB\xa9$\xd64_\xe5\x85\xe4\x97";
  break;
  case #"hash_4b1cca87c9343b3e":
    self.hint_bones["\xdbl\xe44\xe06\x7f\xaf\x7f"] = "H\x18\xf4\xbd{\x88a\x83\x9d\xfc\x1e\xc5\xee\xa0=\xee\x91-\xf8/O\xd7\xe0";
  break;
  case #"hash_b0e39aca048ee194":
    self.hint_bones["\v\xa3\x93\xa4\xddsI\xca\xca"] = "f\x1d\x89\xef\xecHD\x98\x06@f\xc5Z\xab\x99\xda\xb0(\x12\x02M\x90\xbb";
  break;
  case #"hash_fb0f2aea46a63cd4":
    self.hint_bones["\xdb\\\xd9\f&\xcc\xb2~\xe3\xd3<+\x036\\"] = "f\x0f\xfd\xdc\xe9/\xa1Q\x9f\xc3|\x9e\x1e/<\xee#A\x8c\xea{\x05\x15(";
  break;
}
}
}

getin_hint = undefined;

if(isDefined(door.script_linkto)) {
  inside_hint = utility::getStruct(door.script_linkto, "F\x83\x1c\x9d\x19\xc5\xd7\x13;\xb3\x14n\x18\xf5\x13");
  assert(isDefined(inside_hint.script_namenumber), "<dev string:xc7>" + door.script_namenumber);
  getin_hint = strtok(inside_hint.script_namenumber, "w")[1];
  self.getin_hints[getin_hint] = inside_hint;
  self.door_open[getin_hint] = 0;
  door_col = getEnt(door.script_linkto, #script_linkname);

  if(isDefined(door_col)) {
    if(!isDefined(self.door_col)) {
      self.door_col = [];
    }

    door_col linkTo(self.vehicle, self.hint_bones[door.script_namenumber]);
    self.door_col[getin_hint] = door_col;
  }
}

if(isDefined(self.hint_bones[door.script_namenumber])) {
  hint_ent = utility::spawn_tag_origin(self.vehicle gettagorigin(self.hint_bones[door.script_namenumber]));
  hint_ent linkTo(self.vehicle, self.hint_bones[door.script_namenumber]);
} else {
  hint_ent = door utility::spawn_tag_origin();
}

hint_ent.door_name = door.script_namenumber;
self.getin_hints[getin_hint].hint_ent = hint_ent;
hint_ent endon("\x1e\xfd\xd1\xa2\a");
hint_ent cursor_hint::create_cursor_hint("\xec\xbfK|\au\xcd\xc2\x19<", undefined, undefined, 180, 100, 60, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 180);
hint_ent waittill("\x91`\xb1\xe7T\x97>");

if(!self.dont_lerp_player) {
  level.player thread utility_sp::player_gesture_force("GN\xf2\xbd1\xe1\xc2\xf720");
  wait 0.25;
}

move_to = door;

switch (hint_ent.door_name) {
  case #"hash_dbea8a9c1857d183":
    thread interact_vehicle_animate_door("A]");
    break;
  case #"hash_dbea7e9c1857be9f":
    thread interact_vehicle_animate_door("\xf5\x9e");
    break;
  case #"hash_dbfd7a9c1866c2dd":
    thread interact_vehicle_animate_door("\xfc\xc8");
    break;
  case #"hash_dbfd869c1866d5c1":
    thread interact_vehicle_animate_door("3\xa5");
    break;
  case #"hash_f5c2bc7c53ebd2dd":
    thread interact_vehicle_animate_door("]\xcf$p,");
    break;
  case #"hash_2d5a509d1c7e6abf":
    move_to = utility::getStruct(door.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
    thread interact_vehicle_animate_door("3\xa5");
    break;
}

if(self.dont_lerp_player) {}

hint_ent cursor_hint::remove_cursor_hint();
hint_ent delete();
}

function interact_interior_door_open(which_door) {
  hint_ent = undefined;

  switch (which_door) {
    case #"hash_fa27ccf6bd62c1db":
      block_for_mantle(self.getin_hints["\xf5\x9e"]);
      thread interact_vehicle_animate_door("\xf5\x9e");
      self.getin_hints[which_door].hint_ent delete();
      break;
    case #"hash_fa53c4f6bd854785":
      block_for_mantle(self.getin_hints["3\xa5"]);
      thread interact_vehicle_animate_door("3\xa5");
      self.getin_hints[which_door].hint_ent delete();
      break;
  }
}

function interact_interior_door_open_remove(hint_ent) {
  level.player endon("\x1e\xfd\xd1\xa2\a");
  hint_ent endon("\x1e\xfd\xd1\xa2\a");
  utility::flag_waitopen("\xe06,\xcb\xac\x9c}\xa5\x9b\xd1+N\xb0\xc6\xa3\xa5\xb9\xce\xeb\xce+h\xd2\xd8\x1b\x95");
  hint_ent cursor_hint::remove_cursor_hint();
  hint_ent delete();
}

function interact_vehicle_inside(door) {
  getin_key = strtok(door.script_namenumber, "w")[1];

  if(!isDefined(self.getin_hints[getin_key])) {
    return;
  }

  self endon("\x1e\xfd\xd1\xa2\a");
  door endon("\x05\x8d\x7f\xd1\x8bL\x15H\xb3y");
  pathstart = get_next_struct(door);

  if(!isDefined(pathstart)) {
    return;
  }

  pathend = get_next_struct(pathstart);
  block_for_mantle(self.getin_hints[getin_key]);

  foreach(door_struct in self.doors) {
    if(door_struct != door) {
      door_struct notify("\x05\x8d\x7f\xd1\x8bL\x15H\xb3y");
    }
  }

  level.player notify("\x82aqD\x93\xecw\x1a\xf7\xb3?\x19M\x83\xef\xf8\xff ");
  level.interact_vehicle.g_inuse = 1;
  utility::flag_set("\xe06,\xcb\xac\x9c}\xa5\x9b\xd1+N\xb0\xc6\xa3\xa5\xb9\xce\xeb\xce+h\xd2\xd8\x1b\x95");
  var_dc27fca6ae4c7d36 = level.player getstance() == "GX\xa9]\x82";

  if(var_dc27fca6ae4c7d36) {
    level.player val::set("\xf3\x9f+\x1c\xd5\x1dy{_\x19q\x99y\x88<\xf4l\xd19-\xb0Qi", "\x8b\x90\xb5\xc4W", 0);
    level.player val::set("\xf3\x9f+\x1c\xd5\x1dy{_\x19q\x99y\x88<\xf4l\xd19-\xb0Qi", "GX\xa9]\x82", 0);
    wait 0.5;
  }

  var_b4a00c78190d54e9 = @ "hash_2bc9a79b27c6b5af";
  var_e81ca7f4945817bd = 1;

  if(getDvar(var_b4a00c78190d54e9) != "") {
    var_e81ca7f4945817bd = getdvarint(var_b4a00c78190d54e9);
    setsaveddvar(var_b4a00c78190d54e9, 0);
  }

  var_b1804a6e68909345 = level.player getstance() == "1x\xc5\xb4\xabx";

  if(var_b1804a6e68909345 && !var_dc27fca6ae4c7d36) {
    level.player val::set("\xf3\x9f+\x1c\xd5\x1dy{_\x19q\x99y\x88<\xf4l\xd19-\xb0Qi", "\x8b\x90\xb5\xc4W", 0);
  }

  if(!var_dc27fca6ae4c7d36) {
    level.player val::set("\xf3\x9f+\x1c\xd5\x1dy{_\x19q\x99y\x88<\xf4l\xd19-\xb0Qi", "GX\xa9]\x82", 0);
  }

  if(isDefined(self.script_animation)) {
    interact_entry_anim();
  }

  viewheight = level.player getplayerviewheight() + -4;
  cam_mover = utility::spawn_tag_origin(pathstart.origin, level.player.angles);
  p_mover = utility::spawn_tag_origin(pathstart.origin + (0, 0, viewheight * -1), cam_mover.angles);
  level.interact_vehicle.p_mover = p_mover;
  p_mover linkTo(cam_mover);
  time = 0.4;
  level.player playerlinktoblend(p_mover, "\xf6\xfc\xad\x9di\xb9)\xac/K", time, 0, 0.2);
  thread interact_give_control_back(time, p_mover);
  cam_mover moveTo(pathstart.origin, 0.5, 0.1, 0.1);
  cam_mover waittill("\xd4E\xa7\xc7\x1e\xf9\x87%");
  cam_mover.angles = pathstart.angles;
  laststruct = cam_mover interact_vehicle_movement(self, door, pathstart, pathend);

  if(isDefined(level.player.ground_ref_ent)) {
    level interact_vehicle_delete_ground_ref_ent();
  }

  exit_struct = undefined;

  if(laststruct == pathstart) {
    exit_struct = door;
  } else if(door.script_namenumber == "X5\xe8\x82\xa6\xd0\\TY\b" || door.script_namenumber == "\xdb\\\xd9\f&\xcc\xb2~\xc3\xa3") {
    exit_struct = get_opposite_door(door.script_namenumber);
  }

  if(!isDefined(exit_struct)) {
    exit_struct = door;
  }

  cam_mover moveTo(exit_struct.origin, 0.5, 0.1, 0.1);
  cam_mover waittill("\xd4E\xa7\xc7\x1e\xf9\x87%");

  if(getDvar(var_b4a00c78190d54e9) != "") {
    setsaveddvar(var_b4a00c78190d54e9, var_e81ca7f4945817bd);
  }

  level.player val::reset_all("\xf3\x9f+\x1c\xd5\x1dy{_\x19q\x99y\x88<\xf4l\xd19-\xb0Qi");
  level.player unlink();
  cam_mover delete();
  p_mover delete();
  level.interact_vehicle.g_inuse = 0;
  utility::flag_clear("\xe06,\xcb\xac\x9c}\xa5\x9b\xd1+N\xb0\xc6\xa3\xa5\xb9\xce\xeb\xce+h\xd2\xd8\x1b\x95");
  keys = getarraykeys(self.doors);

  foreach(key in keys) {
    if(isDefined(self.door_open[key]) && self.door_open[key]) {
      thread interact_vehicle_inside(self.doors[key]);
    }
  }
}

function block_for_mantle(locator) {
  level endon("\xe8!\x010%\a\xbb\x89\xf1\x10\x18\xfe\xb8\xed\xfd\xa4\xbe");
  level thread create_mantle_hint();

  if(!isDefined(level.interact_vehicle_mantle_hint_active)) {
    level.interact_vehicle_mantle_hint_active = 0;
  }

  for(;;) {
    if(!isDefined(self)) {
      level.player allowjump(1);
      return;
    }

    dist = distance2dsquared(level.player.origin, locator.origin);

    if(dist < 800) {
      if(!level.interact_vehicle_mantle_hint_active) {
        level.interact_vehicle_mantle_hint.alpha = 1;
        level.player allowjump(0);
      }

      level.interact_vehicle_mantle_hint_active = 1;

      if(level.player jumpbuttonPressed()) {
        level.interact_vehicle_mantle_hint.alpha = 0;
        return;
      }
    } else if(dist > 20000) {
      wait 1;
    } else if(dist > 500000) {
      wait 5;
    } else {
      level.interact_vehicle_mantle_hint_active = 0;
      waittillframeend();
      waitframe();

      if(!level.interact_vehicle_mantle_hint_active) {
        level.interact_vehicle_mantle_hint_active = 0;
        level.interact_vehicle_mantle_hint.alpha = 0;
        level.player allowjump(1);
      }
    }

    waitframe();
  }
}

function wait_for_mantle_inside(locator) {
  level notify("\x97J\x15|\x99\xdf&`\x83\xe9_:\xac\xa0\xd6\xe2");
  level endon("\x97J\x15|\x99\xdf&`\x83\xe9_:\xac\xa0\xd6\xe2");
  level thread create_mantle_hint();
  dist = distance2dsquared(level.player.origin, locator.origin);

  print3d(locator.origin, dist, (1, 1, 1), 1, 0.1, 1);

  if(dist < 4) {
    level.interact_vehicle_mantle_hint.alpha = 1;

    if(level.player jumpbuttonPressed()) {
      level.interact_vehicle_mantle_hint.alpha = 0;
      return 1;
    } else {
      return 0;
    }

    return;
  }

  if(dist > 4) {
    level.interact_vehicle_mantle_hint.alpha = 0;
  }

  return 0;
}

function create_mantle_hint() {
  if(isDefined(level.interact_vehicle_mantle_hint)) {
    return;
  }

  level.interact_vehicle_mantle_hint = newhudelem();
  level.interact_vehicle_mantle_hint.x = 320;
  level.interact_vehicle_mantle_hint.y = 350;
  level.interact_vehicle_mantle_hint.alignx = "O\xd5!\xe8\xd4\x9d";
  level.interact_vehicle_mantle_hint.aligny = "#\xb8\xfd\xf5\x1a@";
  level.interact_vehicle_mantle_hint.sort = 1;
  level.interact_vehicle_mantle_hint.foreground = 1;
  level.interact_vehicle_mantle_hint.hidewheninmenu = 1;
  level.interact_vehicle_mantle_hint.alpha = 1;
  level.interact_vehicle_mantle_hint.fontscale = 2;
  level.interact_vehicle_mantle_hint.font = "8\xc5\xe5\x91E\x1b\xf9\xb2e";
  level.interact_vehicle_mantle_hint.text = "b\xd8\x05g8";
  level.interact_vehicle_mantle_hint setshader("\x86\xbaF\xeb\xa5\x1b\xde\x9b_\xb5\x167\xa36\x95", 24, 24);
}

function block_for_push(getin_key, duration) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(duration)) {
    duration = duration;
  } else {
    duration = 6;
  }

  count = 0;

  for(;;) {
    dist = distance2dsquared(level.player.origin, self.getin_hints[getin_key].origin);
    input = level.player getnormalizedmovement();
    dot = math::get_dot(self.getin_hints[getin_key].origin, self.getin_hints[getin_key].angles, level.player.origin);

    if(dist < 900 && abs(input[1]) > 0.2) {
      count += 1;

      if(count > duration) {
        break;
      }
    } else if(dist > 10000) {
      count = 0;
      wait 1;
    } else if(dist > 500000) {
      count = 0;
      wait 5;
    } else {
      count = 0;
    }

    waitframe();
  }
}

function interact_entry_anim() {
  rig = namespace_6341d8b435bf1728::get_player_rig(1);
  rig hide();
  animent = undefined;

  if(isDefined(self.ent)) {
    animent = self.ent;
  } else if(isDefined(self.vehicle)) {
    animent = self.vehicle;
  }

  level.player disableweapons();
  time = 0.4;
  level.player playerlinktoblend(rig, "\xf6\xfc\xad\x9di\xb9)\xac/K", time, 0, 0.2);
  thread interact_give_control_back(time, rig);
  rig utility::delaycall(time, &show);
  animent.animname = animent.script_noteworthy;
  animation = animent utility::getanim(self.script_animation);
  wait 0.1;
  animtime = getanimlength(animation);
  animtime = 1 - (animtime - 2) / animtime;
  wait animtime;
  rig delete();
  level.player enableweapons();
}

function interact_vehicle_delete_ground_ref_ent() {
  ent = level.player.ground_ref_ent;
  ent.vehicleinteract = undefined;
  ent rotateTo((0, 0, 0), 0.3, 0.1, 0.1);
}

function get_next_struct(struct) {
  if(isDefined(struct.target)) {
    return utility::getStruct(struct.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
  }

  return undefined;
}

function get_prev_struct(struct) {
  if(isDefined(struct.targetname)) {
    return utility::getStruct(struct.targetname, "\x7fw*%A\xff");
  }

  return undefined;
}

function get_opposite_door(door_namenumber) {
  var_f3231b831b5b211f = undefined;

  if(door_namenumber == "X5\xe8\x82\xa6\xd0\\TY\b") {
    var_f3231b831b5b211f = "\xdb\\\xd9\f&\xcc\xb2~\xc3\xa3";
  } else if(door_namenumber == "\xdb\\\xd9\f&\xcc\xb2~\xc3\xa3") {
    var_f3231b831b5b211f = "X5\xe8\x82\xa6\xd0\\TY\b";
  }

  doors_avail = utility::getStructArray(self.script_linkto, "F\x83\x1c\x9d\x19\xc5\xd7\x13;\xb3\x14n\x18\xf5\x13");

  foreach(door in doors_avail) {
    if(isDefined(door.script_namenumber) && door.script_namenumber == var_f3231b831b5b211f) {
      return door;
    }
  }

  assertmsg("<dev string:xdd>");
}

function interact_vehicle_movement(struct, door, pathstart, pathend) {
  self endon("\x1e\xfd\xd1\xa2\a");
  range = 100;
  self.pathdir = vectorNormalize(pathend.origin - pathstart.origin);
  dist = length(pathend.origin - pathstart.origin);
  nextpos = pathstart.origin;

  if(!isDefined(pathstart.midpoint)) {
    pathstart.midpoint = spawnStruct();
    pathstart.midpoint.origin = pathstart.origin + self.pathdir * dist * 0.5;
    pathstart.midpoint.angles = pathstart.angles;
    pathstart.midpoint.right = anglestoright(pathstart.angles);
  }

  self.pathstart = pathstart;
  self.movedist = 0;
  self.velocity = 0;
  self.trajectory = 0;
  self.isducking = 0;
  self.prevmoveright = 0;
  childthread interact_vehicle_duck_toggle();
  z = 0;

  while(true) {
    set_moverate_along_dir();
    set_viewangles();
    pathend.open = struct get_end_door_state(door);

    if(!isDefined(pathend.open)) {
      pathend.open = 0;
    }

    if(isDefined(self.forceexit)) {
      break;
    }

    if(self.movelength > 0) {
      var_96c8fc6e3a560f33 = nextpos + self.velocity;
      var_96c8fc6e3a560f33 = (var_96c8fc6e3a560f33[0], var_96c8fc6e3a560f33[1], 0);
      pathstart2d = (pathstart.origin[0], pathstart.origin[1], 0);
      pathend2d = (pathend.origin[0], pathend.origin[1], 0);

      if(vectordot(self.pathdir, vectorNormalize(pathstart2d - var_96c8fc6e3a560f33)) > 0) {
        exit = struct wait_for_mantle_inside(pathstart);

        if(exit) {
          return pathstart;
        } else {
          self.velocity = (0, 0, 0);
        }
      } else if(vectordot(self.pathdir, vectorNormalize(pathend2d - var_96c8fc6e3a560f33)) < 0) {
        exit = struct wait_for_mantle_inside(pathend);

        if(exit) {
          if(!pathend.open) {
            switch (door.script_namenumber) {
              case #"hash_dbea7e9c1857be9f":
                struct thread interact_vehicle_animate_door("3\xa5");
                struct.getin_hints["3\xa5"].hint_ent delete();
                break;
              case #"hash_dbfd869c1866d5c1":
                struct thread interact_vehicle_animate_door("\xf5\x9e");
                struct.getin_hints["\xf5\x9e"].hint_ent delete();
                break;
            }
          }

          return pathend;
        } else {
          self.velocity = (0, 0, 0);
        }
      }
    } else {
      exit = struct wait_for_mantle_inside(pathstart);

      if(exit) {
        return pathstart;
      }

      exit = struct wait_for_mantle_inside(pathend);

      if(exit) {
        if(!pathend.open) {
          switch (door.script_namenumber) {
            case #"hash_dbea7e9c1857be9f":
              struct thread interact_vehicle_animate_door("3\xa5");
              struct.getin_hints["3\xa5"].hint_ent delete();
              break;
            case #"hash_dbfd869c1866d5c1":
              struct thread interact_vehicle_animate_door("\xf5\x9e");
              struct.getin_hints["\xf5\x9e"].hint_ent delete();
              break;
          }
        }

        return pathend;
      }
    }

    nextpos += self.velocity;

    if(self.isducking) {
      if(z > -16) {
        z -= 3;
      }
    } else if(z < 0) {
      z += 3;
    }

    z = clamp(z, -16, 0);
    nextpos_z = nextpos + (0, 0, z);
    self.origin = nextpos_z;
    wait 0.05;
  }

  return pathend;
}

function get_end_door_state(door) {
  switch (door.script_namenumber) {
    case #"hash_dbea8a9c1857d183":
      return 0;
    case #"hash_dbea7e9c1857be9f":
      return self.door_open["3\xa5"];
    case #"hash_dbfd7a9c1866c2dd":
      return 0;
    case #"hash_dbfd869c1866d5c1":
      return self.door_open["\xf5\x9e"];
  }
}

function interact_vehicle_duck_toggle() {
  level.player notifyonplayercommand("OL\xfb:", "z\xf5\xbaH \x13\xbeo\x87");
  level.player notifyonplayercommand("OL\xfb:", "b\x06\xaa`]\xbc\xf5>\xa5\xb5\xff*p");
  level.player notifyonplayercommand("OL\xfb:", "\xe88-\x97\xb82a");

  while(true) {
    level.player waittill("OL\xfb:");
    self.isducking = !self.isducking;
    wait 0.2;
  }
}

function set_moverate_along_dir() {
  range = 3;
  input = level.player getnormalizedmovement();
  forward = anglesToForward(level.player.angles);
  right = anglestoright(level.player.angles);
  inputtrajectory = forward * input[0] + right * input[1];
  trajectory = vectordot(inputtrajectory, self.pathdir) * range;

  if(abs(trajectory) > 0) {
    self.trajectory = trajectory * 0.5;
  } else if(self.trajectory > 0.01) {
    self.trajectory -= self.trajectory * 0.5;
  } else if(self.trajectory < -0.01) {
    self.trajectory -= self.trajectory * 0.5;
  } else {
    self.trajectory = 0;
  }

  speedmult = 1;

  if(self.isducking) {
    speedmult = 0.6;
  }

  self.velocity = self.pathdir * self.trajectory * speedmult;
  self.ismoveright = is_pos_in_front(self.origin, self.origin + self.velocity, self.pathstart.midpoint.right);

  if(self.prevmoveright != self.ismoveright) {
    self.velocity *= 0.2;
  }

  self.prevmoveright = self.ismoveright;
  self.movelength = length(self.velocity);

  if(self.movelength == 0) {
    self.movedist = 0;
  } else {
    self.movedist += self.movelength;

    if(self.movedist > 10) {
      self.movedist = 2;
    }
  }

  scootpercent = self.movedist / 10;
  velmult = get_scoot_velocity(scootpercent);
  self.velocity_bump = get_scoot_velocity_bump(scootpercent);
  self.moveviewmult = velmult;
  self.velocity *= velmult + self.velocity_bump;
}

function get_scoot_velocity(x) {
  pi = 3.14159;
  temp = 2 * pow(x, 1.5) * pi + pi;
  x_degrees = temp * 180 / pi;
  y = (cos(x_degrees) + 1) / 2;
  return y;
}

function get_scoot_velocity_bump(x) {
  bump = 0.2;
  bump += (bump - 0) * x * 2;

  if(bump < 0) {
    bump = 0;
  }

  return bump;
}

function qlerp(from, to, frac) {
  return from + (to - from) * frac;
}

function set_viewangles() {
  level.player endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(level.player.ground_ref_ent)) {
    level.player.ground_ref_ent = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", (0, 0, 0));
  }

  if(!isDefined(level.player.ground_ref_ent.vehicleinteract)) {
    level.player.ground_ref_ent.vehicleinteract = 1;
    level.player playersetgroundreferenceent(level.player.ground_ref_ent);
  }

  groundent = level.player.ground_ref_ent;
  pitch = 2;
  yaw = 1.5;
  roll = -1;

  if(self.ismoveright) {
    yaw *= -1;
    roll *= -1;
  }

  onrightside = is_pos_in_front(self.pathstart.midpoint.origin, self.origin, self.pathstart.midpoint.right);

  if(onrightside) {
    var_299c79fea23fab18 = (0, 0, -5);
  } else {
    var_299c79fea23fab18 = (0, 0, 5);
  }

  d = distance2d(self.pathstart.midpoint.origin, self.origin);
  var_299c79fea23fab18 = anglelerpquatfrac((0, 0, 0), var_299c79fea23fab18, d / 5);
  duckangles = (0, 0, 0);

  if(self.isducking) {
    if(!isDefined(self.duckingtime)) {
      self.duckingtime = gettime();
    }

    time = (gettime() - self.duckingtime) * 0.001;
    duckpercent = time / 0.2 * 1.5;
    duckpercent *= d / 5;
    duckpercent = clamp(duckpercent, 0, 1);

    if(!isDefined(self.prevduckangles)) {
      self.prevduckangles = (0, 0, 0);
    }

    duckrotation = (0, 2, -10);

    if(onrightside) {
      duckangles = anglelerpquatfrac((0, 0, 0), duckrotation, duckpercent);
    } else {
      duckangles = anglelerpquatfrac((0, 0, 0), duckrotation * -1, duckpercent);
    }

    duckangles = anglelerpquatfrac(self.prevduckangles, duckangles, 0.0001);
    self.prevduckangles = duckangles;
  } else {
    self.duckingtime = undefined;
    self.prevduckangles = (0, 0, 0);
  }

  viewangles = (pitch, yaw, roll) * self.moveviewmult;
  viewangles += duckangles + var_299c79fea23fab18;

  if(!isDefined(self.prevviewangles)) {
    self.prevviewangles = (0, 0, 0);
  }

  if(self.moveviewmult < 0.05) {
    viewangles = anglelerpquatfrac(self.prevviewangles, viewangles, 0.1);
  }

  self.prevviewangles = viewangles;

  if(groundent.angles == viewangles) {
    return;
  }

  desiredangles = combineangles(self.pathstart.angles, viewangles);
  up = anglestoup(desiredangles);
  right = vectorcross((1, 0, 0), up);
  forward = vectorcross(up, right);
  desiredangles = axistoangles(forward, right, up);
  groundent.angles = anglelerpquatfrac(groundent.angles, desiredangles, 0.5);
}

function is_pos_in_front(relativepos, objectpos, dir) {
  objectpos2d = (objectpos[0], objectpos[1], 0);
  relativepos2d = (relativepos[0], relativepos[1], 0);
  isinfront = vectordot(dir, vectorNormalize(objectpos2d - relativepos2d));
  return isinfront > 0;
}

function interact_give_control_back(time, ent) {
  wait time;
  level.player playerlinktodelta(ent, "\xf6\xfc\xad\x9di\xb9)\xac/K", 0, 110, 110, 20, 30);
}

function hide_interact_vehicle(noteworthy) {
  vehicle = getscriptablearray(noteworthy, #script_noteworthy)[0];
  vehicle hide();
  return vehicle;
}

function show_interact_vehicle(noteworthy) {
  vehicle = getscriptablearray(noteworthy, #script_noteworthy)[0];
  vehicle show();
  return vehicle;
}

function get_interact_vehicle(noteworthy) {
  foreach(vehicle in level.interact_vehicle.entries) {
    if(isDefined(vehicle.script_noteworthy) && vehicle.script_noteworthy == noteworthy) {
      return vehicle;
    }
  }

  assertmsg("<dev string:xf7>" + noteworthy + "<dev string:x117>");
}

function get_interact_vehicle_array(noteworthy) {
  vehicles = [];

  foreach(vehicle in level.interact_vehicle.entries) {
    if(isDefined(vehicle.script_noteworthy) && vehicle.script_noteworthy == noteworthy) {
      vehicles = utility::array_add(vehicles, vehicle);
    }
  }

  return vehicles;
}

function interact_vehicle_doors_state(doors, state) {
  self endon("\x1e\xfd\xd1\xa2\a");

  foreach(door in doors) {
    if(self.door_open[door]) {
      continue;
    }

    switch (door) {
      case #"hash_8a5c4215db315461":
      case #"hash_fa27c0f6bd62aef7":
      case #"hash_fa27ccf6bd62c1db":
      case #"hash_fa53c4f6bd854785":
      case #"hash_fa53d0f6bd855a69":
        self.dont_lerp_player = 1;
        self.getin_hints[door].hint_ent notify("\x91`\xb1\xe7T\x97>");
        waittillframeend();
        self.dont_lerp_player = 0;
        break;
      default:
        assertmsg(door + "<dev string:x160>");
        break;
    }
  }
}

function interact_vehicle_doors_inactive(doors) {
  self endon("\x1e\xfd\xd1\xa2\a");

  foreach(door in doors) {
    switch (door) {
      case #"hash_8a5c4215db315461":
      case #"hash_fa27c0f6bd62aef7":
      case #"hash_fa27ccf6bd62c1db":
      case #"hash_fa53c4f6bd854785":
      case #"hash_fa53d0f6bd855a69":
        self.getin_hints[door].hint_ent delete();
        break;
      default:
        assertmsg(door + "<dev string:x160>");
        break;
    }
  }
}

function interact_interior_door_hack(which_door) {
  hint_ent = undefined;

  switch (which_door) {
    case #"hash_fa27ccf6bd62c1db":
      hint_ent = utility::spawn_tag_origin(self.vehicle gettagorigin(self.hint_bones["\xdbl\xe44\xe06\x7f\xaf\x7f"]));
      hint_ent cursor_hint::create_cursor_hint("\xec\xbfK|\au\xcd\xc2\x19<", undefined, undefined, 270, 250, 55, 0);
      self.getin_hints["\x83\xa6\x10d\x017\x1d|\xc7"] = spawnStruct();
      self.getin_hints["\x83\xa6\x10d\x017\x1d|\xc7"].hint_ent = hint_ent;
      hint_ent waittill("\x91`\xb1\xe7T\x97>");
      hint_ent delete();
      thread interact_vehicle_animate_door("\xf5\x9e");
      break;
    case #"hash_fa53c4f6bd854785":
      hint_ent = utility::spawn_tag_origin(self.vehicle gettagorigin(self.hint_bones["\v\xa3\x93\xa4\xddsI\xca\xca"]));
      hint_ent cursor_hint::create_cursor_hint("\xec\xbfK|\au\xcd\xc2\x19<", undefined, undefined, 270, 250, 55, 0);
      self.getin_hints["\xd9\xf0<\xe8-\xabOJ\x12"] = spawnStruct();
      self.getin_hints["\xd9\xf0<\xe8-\xabOJ\x12"].hint_ent = hint_ent;
      hint_ent waittill("\x91`\xb1\xe7T\x97>");
      hint_ent delete();
      thread interact_vehicle_animate_door("3\xa5");
      break;
  }
}

function interact_getanim(anime) {
  if(isDefined(level.scr_anim[self.animname]) && isDefined(level.scr_anim[self.animname][anime])) {
    return utility::getanim(anime);
  }

  return level.scr_anim[">n=\xb1\x10 \x894(h|\xfd8\xfe\x1f\xe0"][anime];
}

function interact_vehicle_animate_door(door) {
  self.door_open[door] = 1;
  door_anim = self.vehicle interact_getanim(door + "Q \x0e\xd29");

  if(isDefined(self.door_col) && isDefined(self.door_col[door])) {
    utility::noself_delaycall(getanimlength(door_anim), &createnavobstaclebyent, self.door_col[door], "?\xb1\xc0\x9a", "O\x15\x1b\xad\x9ff");
  }

  self.vehicle setanim(door_anim, 1, 0.2, 2);
  node_back = undefined;
  node_front = undefined;
  door_check = undefined;

  switch (door) {
    case #"hash_fa27c0f6bd62aef7":
      door_check = "\xf5\x9e";
      node_back = "}\xdf+\xcd\xe0@_-\xa3q\xcfpq\xa2";
      node_front = "}\xdf+\xcd\xe0@_-\xa3q\xcfpq\xa2";
      break;
    case #"hash_fa27ccf6bd62c1db":
      door_check = "A]";
      node_back = "}\xdf+\xcd\xe0@_-\xa3q\xcfpq\xa2";
      node_front = "}\xdf+\xcd\xe0@_-\xa3q\xcfpq\xa2";
      break;
    case #"hash_fa53d0f6bd855a69":
      door_check = "3\xa5";
      node_back = "}\xdf+\xcd\xe0@_-\xa3q\xcfpq\xa2";
      node_front = "}\xdf+\xcd\xe0@_-\xa3q\xcfpq\xa2";
      break;
    case #"hash_fa53c4f6bd854785":
      door_check = "\xfc\xc8";
      node_back = "}\xdf+\xcd\xe0@_-\xa3q\xcfpq\xa2";
      node_front = "}\xdf+\xcd\xe0@_-\xa3q\xcfpq\xa2";
      break;
  }

  if(is_van() && (door == "\xfc\xc8" || door == "\xf5\x9e" || door == "3\xa5")) {
    return;
  }

  if(isDefined(node_back)) {
    self.cover_nodes[door] = interact_vehicle_spawn_cover_node(self, door, node_back, "Gs\xe3k\xc1\xcf\x1fPm");

    if(door == "\xf5\x9e" || door == "3\xa5") {
      if(!istrue(self.door_open[door_check])) {
        self.cover_nodes[door + "\x82d\x95,\xda\xd7"] = interact_vehicle_spawn_cover_node(self, door, node_back, "%p\xaf\xa6\xfbb\xce\xcf\xa1\x97");
      }

      return;
    }

    if(door == "A]" || door == "\xfc\xc8") {
      self.cover_nodes[door + "\x82d\x95,\xda\xd7"] = interact_vehicle_spawn_cover_node(self, door, node_back, "%p\xaf\xa6\xfbb\xce\xcf\xa1\x97");

      if(istrue(self.door_open[door_check]) && isDefined(self.cover_nodes[door_check + "\x82d\x95,\xda\xd7"])) {
        despawncovernode(self.cover_nodes[door_check + "\x82d\x95,\xda\xd7"]);
      }
    }
  }
}

function interact_vehicle_spawn_cover_node(parent, door, cover_type, type) {
  cover_node = undefined;

  switch (type) {
    case #"hash_1a9598765e0d7d01":
      cover_node = spawncovernode(parent.doors[door].origin + anglestoup(parent.doors[door].angles) * -50, parent.doors[door].angles, cover_type);
      break;
    case #"hash_b27cf591987f665":
      cover_node = spawncovernode(parent.doors[door].origin + anglestoup(parent.doors[door].angles) * -50 + anglesToForward(parent.doors[door].angles) * 48, parent.doors[door].angles + (0, 180, 0), cover_type);
      break;
    default:
      cover_node = spawncovernode(door.origin + anglestoup(door.angles) * -50, door.angles, cover_type);
      break;
  }

  if(isDefined(parent.script_color_allies) && isDefined(cover_node)) {
    cover_node.script_color_allies = parent.script_color_allies;
    update_color_nodes(cover_node);
  }

  return cover_node;
}

function update_color_nodes(node) {
  if(isDefined(node.script_color_allies)) {
    node add_node_to_global_arrays(node.script_color_allies, "O\x15\x1b\xad\x9ff");
  }

  if(isDefined(node.script_color_axis)) {
    node add_node_to_global_arrays(node.script_color_axis, "?\xb1\xc0\x9a");
  }
}

function add_node_to_global_arrays(colorcode_string, team) {
  self.color_user = undefined;
  colorcodes = strtok(colorcode_string, "\xda");
  colorcodes = colors::array_remove_dupes(colorcodes);

  foreach(colorcode in colorcodes) {
    if(isDefined(level.arrays_of_colorcoded_nodes[team]) && isDefined(level.arrays_of_colorcoded_nodes[team][colorcode])) {
      if(!arraycontains(level.arrays_of_colorcoded_nodes[team][colorcode], self)) {
        level.arrays_of_colorcoded_nodes[team][colorcode] = utility::array_add(level.arrays_of_colorcoded_nodes[team][colorcode], self);
        continue;
      }
    }

    level.arrays_of_colorcoded_nodes[team][colorcode][0] = self;
    level.arrays_of_colorcoded_ai[team][colorcode] = [];
    level.arrays_of_colorcoded_spawners[team][colorcode] = [];
  }
}

function is_van() {
  if(isDefined(self.script_animname) && self.script_animname == "n\x9fto\x94\xf0\x9f\xd4") {
    return true;
  }

  return false;
}