/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\move.gsc
***********************************************/

mayshootwhilemoving() {
  if(nullweapon(self.weapon))
    return 0;

  var_0 = weaponclass(self.weapon);

  if(!_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::usingriflelikeweapon())
    return 0;

  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isasniper()) {
    if(!_encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::iscqbwalking() && self.facemotion)
      return 0;
  }

  if(istrue(self.dontshootwhilemoving))
    return 0;

  return 1;
}