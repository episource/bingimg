# Description
The powershell script `get-bingimg.ps1` uses bing's web api to retrieve the most recent images from bings start page. It supports several resolution and optionally adds an title to the image.

# Usage
`./get-bingimg -TargetDir <dir> [-BingCountryCode <de-DE>] [-Resolution <1920x1080>] [-Max <1>] [-AddTitle] [-TitleHPos <Center>] [-TitleVPos <Bottom>] [-TitleSize <14>] [-TitleColor <#cfcfcf>] [-TitleVertical]`
- **TargetDir**
  <br/>Directory where downloaded images are saved. Existing images won't be downloaded again.
- **BingCountryCode** - *optional, default: de-DE*
  <br/>Bing uses different front page images in different countries. This locale string selects which version you get.
- **Resolution** - *optional, default: 1920x1080*
  <br/>Desired image resolution. Possible values: `1024x768`, `1280x768`, `1366x768`, `1920x1080`, `1920x1200`
- **Max** - *optional, default: 1*
  <br/>Select how many images should be requested. Up to this number of images are downloaded if they do not yet exist in the target directory.
- **AddTitle** - *switch, default: $false*
  <br/>Add a watermark with the image title/description to the downloaded image.
- **TitleHPos** - *optional, default: Center*
  <br/>Horizontal position of the title watermark. Possible values: `Left`, `Center`, `Right`
- **TitleVPos** - *optional, default: Bottom* 
  <br/>Vertical position of the title watermark. Possible values: `Top`, `Center`, `Bottom`
- **TitleSize** - *optional, default: 14*
  <br/>Text size of the image title watermark.
- **TitleColor** - *optional, default: #cfcfcf*
  <br/>Text foreground color of the image title watermark.
- **TitleVertical** - *switch, default: $false*
  <br/>Change the title orientation to vertical (default is horizontal). The text direction will be top-to-bottom if aligned left, otherwise bottom-to-top.