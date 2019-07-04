function Clear-AFTrashCan {
    Invoke-AFApi -Path '/trash/empty' -Method "POST"
}