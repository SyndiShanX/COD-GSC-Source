/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_ctf.csc
**************************************/

init() {
  level._client_flag_callbacks["scriptmover"][6] = ::setctfaway;
}

setctfaway(localclientnum, set) {
  team = self.team;
  setflagasaway(localclientnum, team, set);
  self thread clearctfaway(localclientnum, team);
}

clearctfaway(localclientnum, team) {
  self waittill("entityshutdown");
  setflagasaway(localclientnum, team, 0);
}