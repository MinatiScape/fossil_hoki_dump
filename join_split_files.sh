#!/bin/bash

cat system/system/product/priv-app/PrebuiltGmsCoreForClockworkWearable/PrebuiltGmsCoreForClockworkWearable.apk.* 2>/dev/null >> system/system/product/priv-app/PrebuiltGmsCoreForClockworkWearable/PrebuiltGmsCoreForClockworkWearable.apk
rm -f system/system/product/priv-app/PrebuiltGmsCoreForClockworkWearable/PrebuiltGmsCoreForClockworkWearable.apk.* 2>/dev/null
