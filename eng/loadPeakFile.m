function D = loadPeakFile(filename)
% D = loadPeakFile(filename);
% D contains elements:
%  peak: peak height in some unknown units
%  width: width in some unknown units
%  dt: microseconds since previous peak
%  peak_datetime: seconds since 1970
fileinfo = dir(filename);
if isempty(fileinfo)
  error('File not found with pattern ''%s''', filename);
end
filesize = fileinfo(1).bytes;
init_size = ceil(filesize/3);
peak = NaN*zeros(init_size,1);
width = NaN*zeros(init_size,1);
dt = NaN*zeros(init_size,1);
peak_datetime = NaN*zeros(init_size,1);

fd = fopen(filename);
c = 0;
bytes_read = 0;
num_elements = 3;
while bytes_read < filesize
  array_len = fread(fd, 1, 'int32');
  bbb_seconds = fread(fd, 1, 'double');
  bytes_read = bytes_read + 12;
  A = fread(fd, [num_elements,array_len], 'int32');
  bytes_read = bytes_read + num_elements*array_len*4;
  peak_data = A';
  us_from_start = cumsum(peak_data(:,3));
  peak(c+(1:array_len)) = peak_data(:,1);
  width(c+(1:array_len)) = peak_data(:,2);
  dt(c+(1:array_len)) = peak_data(:,3);
  peak_datetime(c+(1:array_len)) = bbb_seconds + us_from_start/1e6;
  c = c + array_len;
end
fclose(fd);

D.peak = peak(1:c);
D.width = width(1:c);
D.dt = dt(1:c);
D.peak_datetime = peak_datetime(1:c);
