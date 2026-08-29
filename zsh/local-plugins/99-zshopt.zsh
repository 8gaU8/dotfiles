setopt alwaystoend
setopt autocd
setopt autopushd
setopt combiningchars
setopt completeinword
setopt extendedhistory
setopt noflowcontrol
setopt histexpiredupsfirst
setopt histignoredups
setopt histignorespace
setopt histverify
setopt interactive
setopt interactivecomments
setopt login
setopt longlistjobs
setopt promptsubst
setopt pushdignoredups
setopt pushdminus
setopt sharehistory

# ref: https://tec.tecotec.co.jp/entry/2023/12/23/000000
# 補完系
setopt always_last_prompt # 補完でプロンプト位置を保持
setopt auto_list          # 曖昧補完
setopt auto_menu          # 補完キー（Tab）連打で補完を順に表示
setopt auto_param_keys    # カッコなどを補完
setopt extended_glob      # globを使用
setopt list_types         # 候補にファイルの種別を表示

# cdとhistory系
setopt extended_history   # historyにタイムスタンプも記録する
setopt hist_ignore_dups   # historyの連続を削除
setopt hist_reduce_blanks # historyの余分な空白削除
setopt hist_ignore_space  # コマンド先頭にスペースをいれたらhistoryに入れない

# # その他
setopt auto_remove_slash # 不要な「/」を削除
# ↓ これを有効にすると^Dで閉じれない
# setopt ignore_eof # ファイル末尾で勝手に閉じない
setopt no_beep       # ビープ音を消す
setopt multios       # マルチリダイレクト
setopt sh_word_split # 変数の分割ルールをスペース区切りにする
setopt noclobber     # リダイレクトによる上書きを禁止

# ignore case for completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
