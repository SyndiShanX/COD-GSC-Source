/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_notetracks.csc
*************************************************/

#using scripts\shared\ai_shared;
#using scripts\shared\util_shared;
#namespace notetracks;

function autoexec main() {
  if(sessionmodeiszombiesgame() && getdvarint("splitscreen_playerCount") > 2) {
    return;
  }
  if(sessionmodeiscampaigndeadopsgame() && getdvarint("splitscreen_playerCount") > 2) {
    return;
  }
  ai::add_ai_spawn_function(&initializenotetrackhandlers);
}

function private initializenotetrackhandlers(localclientnum) {
  addsurfacenotetrackfxhandler(localclientnum, "jumping", "surfacefxtable_jumping");
  addsurfacenotetrackfxhandler(localclientnum, "landing", "surfacefxtable_landing");
  addsurfacenotetrackfxhandler(localclientnum, "vtol_landing", "surfacefxtable_vtollanding");
}

function private addsurfacenotetrackfxhandler(localclientnum, notetrack, surfacetable) {
  entity = self;
  entity thread handlesurfacenotetrackfx(localclientnum, notetrack, surfacetable);
}

function private handlesurfacenotetrackfx(localclientnum, notetrack, surfacetable) {
  entity = self;
  entity endon("entityshutdown");
  while(true) {
    entity waittill(notetrack);
    fxname = entity getaifxname(localclientnum, surfacetable);
    if(isDefined(fxname)) {
      playFX(localclientnum, fxname, entity.origin);
    }
  }
}