// Copyright (c) 2004-2007 University of Geneva, HEC, Logilab
//
// OBOE is published under the Common Public License.
//
// Authors :
// Nidhi Sawhney <nsawhney@yahoo.com>
// The OBOE team
//

#include "Oracle.h"

namespace Accpm {
Oracle::Oracle(OracleFunction *f1, OracleFunction *f2)
{
  _f1 = f1;
  _f2 = f2;
}

Oracle::~Oracle()
{
}

}
