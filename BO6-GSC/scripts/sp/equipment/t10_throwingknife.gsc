/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\equipment\t10_throwingknife.gsc
******************************************************/

#using scripts\common\callbacks;
#using scripts\sp\equipment\offhands;
#using scripts\sp\loot;
#namespace t10_throwingknife;

function private autoexec function_1a26cf1b9776a374() {
  offhands::registerprecachefunc("\xb7\xf9_\xe5\x86\xb3\\\xfaw\xaaG\x81\xc5\x9b\x99K\xda\xf1\xe7\x8b", &precache);
}

function private precache(offhand) {
  offhands::registeroffhandfirefunc(offhand, &throwingknifefiremain);
  callback::add("\xcepK{\x02\xc7\xecXl\x8e\ag\xff", &function_93600004f257734c);
}

function private function_93600004f257734c(params) {
  self.var_e0cde25af3061db1 = 1;
}

function private throwingknifefiremain(knifeprojectile, weapon) {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  knifeprojectile endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(knifeprojectile)) {
    return;
  }

  originpos = knifeprojectile.origin;
  knifeprojectile waittill("d\xd9b~\xf2\x9f\x15\x93T\xd1\x04\x1a\x18", stuckto, tag, surfaceflags, vel, pos, normal);
  knifeprojectile.stuckto = stuckto;
  depth = 1;

  if(isai(stuckto)) {
    depth = 3;
  }

  origin = knifeprojectile.origin + anglesToForward((0, knifeprojectile.angles[1], 0)) * depth + (0, 0, -4);
  stickangles = vectortoangles(knifeprojectile.origin - originpos);
  angles = (stickangles[0] + 90, knifeprojectile.angles[1], 0);
  hitshield = isDefined(tag) && tag == #"j_riotshield_offset";

  if(isai(stuckto) && !hitshield) {
    if(istrue(stuckto.var_e0cde25af3061db1)) {
      item = loot::spawnlootitem("VK\n\xdb\xd0(O'T]\x12K\x8e", origin, angles, 1, 0, 0, 1);
    } else {
      item = loot::spawnlootitem("VK\n\xdb\xd0(O'T]\x12K\x8e", origin, angles, 1, 0, 1, 0);
      item notsolid();
      linked = 0;

      if(isDefined(tag)) {
        tagorigin = stuckto gettagorigin(tag, 1, 0, 0);
        tagangles = stuckto gettagangles(tag, 1, 0, 0);

        if(isDefined(tagorigin) && isDefined(tagangles)) {
          localtagorigin = coordtransformtranspose(origin, tagorigin, tagangles);
          localtagangles = combineanglesinverted(tagangles, angles);
          item linkTo(stuckto, tag, localtagorigin, localtagangles);
          linked = 1;
        }
      }

      if(!linked) {
        item linkTo(stuckto);
      }

      item thread stuck_wait(stuckto);
    }
  } else if(isDefined(stuckto) || hitshield || issubstr(surfaceflags ?? "", "\xcel\x85s\xe6")) {
    item = loot::spawnlootitem("VK\n\xdb\xd0(O'T]\x12K\x8e", origin, angles, 1, 0, 0, 1);
  } else {
    item = loot::spawnlootitem("VK\n\xdb\xd0(O'T]\x12K\x8e", origin, angles, 1, 0, 1, 0);
  }

  knifeprojectile delete();
}

function private stuck_wait(stuckto) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  stuckto waittill("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  item = loot::spawnlootitem("VK\n\xdb\xd0(O'T]\x12K\x8e", self.origin + (0, 0, 10), self.angles, 1, 0, 0, 1);
  self delete();
}