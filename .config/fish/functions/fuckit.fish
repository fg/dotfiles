#author https://www.github.com/evanlucas

function fuckit --description 'Kill process(s) matching name'
  set -l red (set_color -o 032)
  set -l magenta (set_color -o 171)
  set -l green (set_color -o 034)
  switch (count argv)
    case 0
      printf "\n%sERR!%s fucked <name>\n" (set_color red) (set_color normal)
      return 1
  end

  set -l pids (ps axc | grep $argv | grep -v grep | awk '{print $1 " " $5}')

  switch (count $pids)
    case 0
      printf "\n%sERR!%s no pids found\n" (set_color red) (set_color normal)
      return 1
    case '*'
      printf "\n%sinfo%s found %s pids" (set_color green) (set_color normal) (count $pids)
  end

  for pid in $pids
    set -l pi (echo $pid | awk '{print $1}')
    set -l name (echo $pid | awk '{print $2}')
    printf "\n%sinfo%s killing PID %s%6s%s - %s" (set_color green) (set_color normal) (set_color magenta) $pi (set_color normal) $name
    kill -9 $pi
  end

  echo
end
