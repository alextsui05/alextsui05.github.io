#!/bin/bash
X=$(ls _posts/*weekly-update* | tail -n1 | cut -d- -f6)
X=$(echo ${X%%.md} | sed s/^0*//)
X2=$(printf "%03d" $((X + 1)))
DATE=$(date +%Y-%m-%d)
cat > _posts/${DATE}-weekly-update-${X2}.md << EOF
---
title: Weekly Update $(echo $((X + 1)))
category: 'Weekly Update'
---

EOF
vi _posts/${DATE}-weekly-update-${X2}.md
