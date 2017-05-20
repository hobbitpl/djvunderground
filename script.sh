# source: https://forum.diybookscanner.org/viewtopic.php?f=3&t=2555

minidjvu -d 600 -i -r -l page*.tif indirect.djvu

# let's say page 3 has a diagram, which I've resampled to 120dpi and run through c44
# we need to get the BG44 chunk out of it
djvuextract page-003image.djvu BG44=page-003image.bg44

# now move the minidjvu output out of the way...
mv page-003.djvu page-003text.djvu

# ... and replace it with the combined text and graphics page:
djvumake page-003.djvu INFO=,,600 Sjbz=page-003text.djvu INCL=pages-001.iff BG44=pages-003.bg44


################################################


# get the total number of files...
file_count=$(ls -1 page-???.tif | wc -l)

echo "There are $file_count files to process."

# figure out how many files per run of minidjvu to use
# in order to run 4 to 5 instances of it concurrently
numpermini=$((file_count / 4))
if [ $numpermini -lt 10 ]
then
  numpermini=10
fi