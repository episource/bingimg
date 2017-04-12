# Description
The powershell script `get-bingimg.ps1` uses bing's web api to retrieve the most recent images from bings start page (bing image of the day). It supports several resolutions and optionally adds an title to the image.

# Usage
`./get-bingimg -TargetDir <dir> [-BingCountryCode <de-DE>] [-Resolution <1920x1080>] [-Max <1>] [-AddTitle] [-TitleHPos <Center>] [-TitleVPos <Bottom>] [-TitleSize <14>] [-TitleColor <#d8d8d8>] [-TitleMargin <0>] [-TitleVertical]`
- **TargetDir**
  <br/>Directory where downloaded images are saved. Existing images won't be downloaded again.
- **BingCountryCode** - *optional, default: de-DE*
  <br/>Bing uses different front page images in different countries. This locale string selects which version you get.
- **Resolution** - *optional, default: 1920x1080*
  <br/>Desired image resolution. Possible values: `1024x768`, `1280x768`, `1366x768`, `1920x1080`, `1920x1200`
- **Max** - *optional, default: 1*
  <br/>Select how many images should be requested. Up to this number of images are downloaded if they do not yet exist in the target directory and the web service is able to provide enough pictures (typically up to 8 images are available).
- **AddTitle** - *switch, default: $false*
  <br/>Add a watermark with the image title/description to the downloaded image.
- **TitleHPos** - *optional, default: Center*
  <br/>Horizontal position of the title watermark. Possible values: `Left`, `Center`, `Right`
- **TitleVPos** - *optional, default: Bottom* 
  <br/>Vertical position of the title watermark. Possible values: `Top`, `Middle`, `Bottom`
- **TitleSize** - *optional, default: 12*
  <br/>Text size of the image title watermark.
- **TitleColor** - *optional, default: #d8d8d8*
  <br/>Text foreground color of the image title watermark.
- **TitleMargin** - *optional, default: 0*
  <br/>Margin between the title text area and the screen border.
- **TitleVertical** - *switch, default: $false*
  <br/>Change the title orientation to vertical (default is horizontal). The text direction will be top-to-bottom if aligned left, otherwise bottom-to-top.