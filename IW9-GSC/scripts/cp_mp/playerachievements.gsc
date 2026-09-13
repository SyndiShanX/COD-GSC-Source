/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\playerachievements.gsc
************************************************/

_id_0B3EA117EB5FBB4A(player, _id_4B86A4E17C656399) {
  if(!isDefined(player._id_3B3A45AF0209FF05))
    player._id_3B3A45AF0209FF05 = [];

  if(!isDefined(player._id_3B3A45AF0209FF05[_id_4B86A4E17C656399])) {
    player._id_3B3A45AF0209FF05[_id_4B86A4E17C656399] = spawnStruct();
    player._id_3B3A45AF0209FF05[_id_4B86A4E17C656399]._id_B92E5E700D2F73A8 = 0;
    player._id_3B3A45AF0209FF05[_id_4B86A4E17C656399].progress = 0;
    player._id_3B3A45AF0209FF05[_id_4B86A4E17C656399]._id_0ABC57BB73D4BF1A = 0;
  }
}

_id_CF013B45184BB054(player, _id_4B86A4E17C656399) {
  _id_0B3EA117EB5FBB4A(player, _id_4B86A4E17C656399);
  player _meth_86AF48E06C94360A(_id_4B86A4E17C656399);
}

_id_C469BBF9E3FBBB78(player, _id_4B86A4E17C656399, progress, _id_0ABC57BB73D4BF1A) {
  _id_0B3EA117EB5FBB4A(player, _id_4B86A4E17C656399);
  player._id_3B3A45AF0209FF05[_id_4B86A4E17C656399].progress = progress;
  player._id_3B3A45AF0209FF05[_id_4B86A4E17C656399]._id_0ABC57BB73D4BF1A = _id_0ABC57BB73D4BF1A;
  player notify("challengeProgress", _id_4B86A4E17C656399);
}