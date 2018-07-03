#!/bin/bash
# A better vimdiff mergetool for Git
#
# Git does a great job resolving merge conflicts automatically but there are
# times when human intervention is still needed. Git resolves all the conflicts
# that it is able to and finally wraps each conflict it cannot resolve within
# special markers which must be resolved by a human.
#
# The vertical format and lack of syntax highlighting in the plain conflict
# marker layout makes it difficult to spot subtle conflicts such as
# single-character changes and this is where a two-way diff really shines!
# To see this explained using screenshots, see:
# http://vim.wikia.com/wiki/A_better_Vimdiff_Git_mergetool
#
# This script, when used as a Git mergetool, opens each "side" of the conflict
# markers in a two-way vimdiff window. This combines all the awesome of Git's
# automatic merging savvy with the awesome and simplicity of a simple two-way
# diff.
#
# Add this mergetool to your ~/.gitconfig (you can substitute gvim for vim):
#
# git config --global merge.tool diffconflicts
# git config --global mergetool.diffconflicts.cmd 'diffconflicts vim $BASE $LOCAL $REMOTE $MERGED'
# git config --global mergetool.diffconflicts.trustExitCode true
# git config --global mergetool.diffconflicts.keepBackup false
#
# The next time you perform a merge with conflicts, invoke this tool with the
# following command. (Of course you can set it as your default mergetool as
# well.)
#
#   git mergetool --tool diffconflicts
#
# This tool can open three tabs in Vim that each provide a different way to
# view the conflicts. You can resolve the conflicts in the first tab and save
# and exit the file. This will also mark the conflict as resolved in Git.
# Only the first tab is opened by default so Vim loads more quickly and also
# because the other tabs are only occasionally useful for tough merges. To open
# Tab2 and Tab3 use the mapping <leader>D.
#
#   Tab1 is a two-way diff of just the conflicts. Resolve the conflicts here
#   and save the file.
#       +--------------------------------+
#       |    LCONFL     |    RCONFL      |
#       +--------------------------------+
#   Tab2 is a three-way diff of the original files and the merge base. This is
#   the traditional three-way diff. Although noisy, it is occasionally useful
#   to view the three original states of the conflicting file before the merge.
#       +--------------------------------+
#       |  LOCAL   |   BASE   |  REMOTE  |
#       +--------------------------------+
#   Tab3 is the in-progress merge that Git has written to the filesystem
#   containing the conflict markers. I.e., the file you would normally edit by
#   hand when not using a mergetool.
#       +--------------------------------+
#       |       <<<<<<< HEAD             |
#       |        LCONFL                  |
#       |       =======                  |
#       |        RCONFL                  |
#       |       >>>>>>> someref          |
#       +--------------------------------+
#
# Workflow:
#
# 1.    Save your changes to the LCONFL temporary file (the left window on the
#       first tab; also the only file that isn't read-only).
# 2.    The LOCAL, BASE, and REMOTE versions of the file are available in the
#       second tabpage if you want to look at them.
# 3.    When vimdiff exits cleanly, the file containing the conflict markers
#       will be updated with the contents of your LCONFL file edits.
#
# NOTE: Use :cq to abort the merge and exit Vim with an error code.

if [[ -z $@ || $# != "5" ]] ; then
    echo -e "Usage: $0 \$EDITOR \$BASE \$LOCAL \$REMOTE \$MERGED"
    exit 1
fi

cmd=$1
BASE="$2"
LOCAL="$3"
REMOTE="$4"
MERGED="$5"
printf -v QBASE '%q' "${BASE}"
printf -v QLOCAL '%q' "${LOCAL}"
printf -v QREMOTE '%q' "${REMOTE}"
printf -v QMERGED '%q' "${MERGED}"

# Use gnu sed if on OSX for better portability (brew install gnu-sed)
GNU_SED="gsed"
type $GNU_SED >/dev/null 2>&1 || GNU_SED="sed"

# Temporary files for left and right side, keeping file extensions for syntax highlighting
MERGED_PATH="$(dirname ${MERGED})"
MERGED_FILE="$(basename ${MERGED})"
LCONFL="${MERGED_PATH}/.REMOTE.$$.${MERGED_FILE}"
RCONFL="${MERGED_PATH}/.LOCAL.$$.${MERGED_FILE}"

# Always delete our temp files; Git will handle it's own temp files
trap 'rm -f "'"${LCONFL}"'" "'"${RCONFL}"'"' SIGINT SIGTERM EXIT

# Remove the conflict markers for each 'side' and put each into a temp file
$GNU_SED -r -e '/^<<<<<<< /,/^=======\r?$/d' -e '/^>>>>>>> /d' "${MERGED}" > "${LCONFL}"
$GNU_SED -r -e '/^=======\r?$/,/^>>>>>>> /d' -e '/^<<<<<<< /d' "${MERGED}" > "${RCONFL}"

# Fire up vimdiff
$cmd -f -R -d "${LCONFL}" "${RCONFL}" \
     -c ":set noro" \
	 -c ":nnoremap <leader> :tabe $QLOCAL<CR>:vert diffs $QBASE<CR>:vert diffs $QREMOTE<CR>:winc t<CR>:tabe $QMERGED<CR>:tabfir<CR>"
EC=$?

# Overwrite $MERGED only if vimdiff exits cleanly.
if [[ $EC == "0" ]] ; then
    cat "${LCONFL}" > "${MERGED}"
fi

exit $EC
