# Servidor local simples para testar o caderno em http://localhost:5500
$root = Split-Path $PSScriptRoot -Parent
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:5500/")
$listener.Start()
Write-Host "Servindo $root em http://localhost:5500/"
$types = @{ ".html" = "text/html; charset=utf-8"; ".js" = "text/javascript; charset=utf-8"; ".css" = "text/css"; ".md" = "text/markdown; charset=utf-8"; ".json" = "application/json" }
while ($listener.IsListening) {
  $ctx = $listener.GetContext()
  $path = [Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath.TrimStart("/"))
  if (-not $path) { $path = "index.html" }
  $file = Join-Path $root $path
  if ((Test-Path $file -PathType Leaf) -and ([IO.Path]::GetFullPath($file).StartsWith($root))) {
    $bytes = [IO.File]::ReadAllBytes($file)
    $ext = [IO.Path]::GetExtension($file)
    $ctx.Response.ContentType = if ($types[$ext]) { $types[$ext] } else { "application/octet-stream" }
    $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
  } else { $ctx.Response.StatusCode = 404 }
  $ctx.Response.Close()
}
