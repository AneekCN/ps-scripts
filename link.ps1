param(
    [string[]]
    [Parameter(Mandatory = $True)]
    $pattern,

    [string[]] 
    [Parameter(Mandatory = $True)]
    $sources,

    [string] $dest = "."
)

foreach ( $src in $sources ) {

    if ( $src -ne $dest ) {

        $source = "$src\*"

        foreach ($pat in $pattern) {

            $files = Get-ChildItem -Path $source -Include $pat
    
            foreach ( $target  in $files ) { 
                $name = $target.Name
                $path = "$dest\$name" 

                if ( Test-Path $path -PathType Leaf ) {
                    Write-Output "removed $path "
                    Remove-Item -Path $path -Force
                }
            
                New-Item -ItemType HardLink -Path $path -Target $target | out-null
                Write-Output "Creating link for $target at $path"
            }
        }
    }
}