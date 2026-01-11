#include common_scripts\utility;

sanitise_name(name) {
  return maps\mp\gametypes\_playerlogic::extractplayername(name);
}

getkillstreakcrateicon(var_0) {
  return tablelookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0, 26);
}

/*
addDogPoint(classname, origin, angles, target)
{
if(!isDefined(level.dogPoints[classname])) {
level.dogPoints[classname] = [];
}

ent = spawnStruct();
ent.origin = origin;
ent.angles = angles;
ent.target = target;
level.dogPoints[classname][level.dogPoints[classname].size] = ent;

mapName = getDvar("mapname");
if(classname == "dog_waypoint")
{
newOrigin = undefined;

if(int(ent.origin[0]) == 396 && mapName == "mp_terminal") {
return;
}
if(mapName == "so_bridge")
{
if(ent.origin == (10341.1, 37319.1, 347.35)) {
return;
}
else if(ent.origin == (10152.1, 36238.2, 305.952)) {
newOrigin = (10260.5, 36215.3, 292.768);
}
else if(ent.origin == (10679.2, 37412.9, 351.792)) {
newOrigin = (10538, 37392.8, 350.84);
}
else if(ent.origin == (10705.4, 37579.1, 425.432)) {
newOrigin = (10584.6, 37661.6, 484.207);
}
else if(ent.origin == (10722.1, 37731.9, 402.41)) {
newOrigin = (10784.2, 38194.8, 472.52);
}
}
else if(mapName == "dc_whitehouse")
{
if(ent.origin == (-2566.89, 11507.1, -244.875)) {
newOrigin = (-2450.4, 11442.4, -250.875);
}
else if(ent.origin == (-3337.96, 11758, -244.875)) {
newOrigin = (-3175.44, 11824.9, -244.875);
}
else if(ent.origin == (-2180.67, 11507.3, -262.875)) {
newOrigin = (-2249.33, 11390.1, -274.875);
}
else if(ent.origin == (-3193.46, 11814.7, -244.875)) {
newOrigin = (-3371.17, 11765.2, -244.875);
}
}
else if(mapName == "roadkill")
{
if(ent.origin == (-8046.88, 10771.9, 536.096)) {
newOrigin = (-7908.08, 10860.6, 536.157);
}
else if(ent.origin == (-8788.98, 9409.97, 624.125)) {
newOrigin = (-8808.83, 9497.02, 624.125);
}
else if(ent.origin == (-9117.11, 10118.7, 624.125) || ent.origin == (-9134.24, 10156.5, 655.925) || ent.origin == (-9154.66, 10249.1, 624.125)) {
return;
}
else if(ent.origin == (-9573.14, 10286.7, 622.342)) {
newOrigin = (-9417.96, 10298.4, 622.125);
}
}
else if(mapName == "gulag" && ent.origin == (-2014.9, 527.846, 1869.82))
{
newOrigin = (-1790.54, 515.523, 1866.13);
}
else if(mapName == "af_caves")
{
if(ent.origin == (9629.16, 8426.11, -3511.5)) {
newOrigin = (9963.19, 8889.91, -3541.3);
}
else if(ent.origin == (9883.21, 8350.47, -3505.18)) {
newOrigin = (10158.6, 8802.53, -3484.12);
}
}
}
}

getCursorPos(vec, altStyle, ignoreEnt)
{
if(!isDefined(vec)) {
vec = 1000000;
}

if(!isDefined(ignoreEnt)) {
ignoreEnt = self;
}

if(isDefined(altStyle) && altStyle)
{
start = ignoreEnt getTagOrigin("tag_flash");
return bulletTrace(start, start + vector_multiply(anglesToForward(self getPlayerAngles()), 100), 0, ignoreEnt)[ "position" ]; //better trace for remote sentry
}

return bulletTrace(self getEye(), vector_multiply(anglesToForward(self getPlayerAngles()), vec), 0, ignoreEnt)[ "position" ];
}

setKillcamEnt(entity)
{
self.newKillcamEntity = entity; //implemented in _damage.gsc

if(isDefined(self.cleanKillcamEntity)) {
self.cleanKillcamEntity = undefined;
}
}

clearKillcamEnt()
{
self.cleanKillcamEntity = true; //implemented in _damage.gsc

if(isDefined(self.newKillcamEntity)) {
self.newKillcamEntity = undefined;
}
}

add_hint_string_delayed(delay, text, endonString1, endonString2, endonString3)
{
level endon("game_ended");
self endon("disconnect");

if(isDefined(endonString1)) {
self endon(endonString1);
}

if(isDefined(endonString2)) {
self endon(endonString2);
}

if(isDefined(endonString3)) {
self endon(endonString3);
}

wait delay;

self thread add_hint_string(text, endonString1, endonString2, endonString3);
}

add_hint_string(text, endonString1, endonString2, endonString3)
{
level endon("game_ended");
self endon("disconnect");
self endon("joined_team");
self endon("joined_spectators");

if(level.gameEnded || !isDefined(text) || !isDefined(self)) {
return;
}
self notify("hint_string_added");
self endon("hint_string_added");

self show_hint_string(text, endonString1, endonString2, endonString3);
self.hint_string.alpha = 0;
}

show_hint_string(text, endonString1, endonString2, endonString3)
{
if(isDefined(endonString1)) {
self endon(endonString1);
}

if(isDefined(endonString2)) {
self endon(endonString2);
}

if(isDefined(endonString3)) {
self endon(endonString3);
}

if(!isDefined(self.hint_string))
{
self.hint_string = self maps\mp\gametypes\_hud_util::createFontString("default", 2);
self.hint_string maps\mp\gametypes\_hud_util::setPoint("center", "middle", 0, -68);
self.hint_string.foreground = false;
self.hint_string.archived = false;
self.hint_string.hidewheninmenu = true;
self.hint_string.alpha = 0;
}

self.hint_string setText(text);
self.hint_string fadeOverTime(1);
self.hint_string.alpha = 0.8;

wait 4;

self.hint_string fadeOverTime(1);
}

spawnTagOrigin(origin, angles)
{
tag_origin = spawn("script_model", origin);
tag_origin setModel("tag_origin");
tag_origin notSolid();

if(isDefined(angles)) {
tag_origin.angles = angles;
}

return tag_origin;
}
*/

_visionsetnaked(visionSet, time) {
  mapname = getdvar("mapname");

  if(visionSet == "" && !issubstr(mapname, "mp_")) {
    visionsetnaked(mapname, time);
  }
  else {
    visionsetnaked(visionSet, time);
  }
}

_visionsetnakedforplayer(visionset, time) {
  mapname = getdvar("mapname");
  if(visionset == "" && !issubstr(mapname, "mp_")) {
    self visionsetnakedforplayer(mapname, time);
  }
  else {
    self visionsetnakedforplayer(visionset, time);
  }
}

remove_undefined_from_array(array) {
  newarray = [];
  for(i = 0; i < array.size; i++) {
    if(!isDefined(array[i])) {
      continue;
    }
    newarray[newarray.size] = array[i];
  }
  return newarray;
}

vector_multiply(var_0, var_1) {
  var_0 = (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
  return var_0;
}