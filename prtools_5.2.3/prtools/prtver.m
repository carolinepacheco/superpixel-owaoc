%PRTVER Get PRTools version
%
%This routine is intended for internal use in PRTools only

function out = prtver

persistent PRTVERSION
%if ~isempty (PRTVERSION)
%	prtversion = PRTVERSION;
%else
  [dummy,prtoolsname] = fileparts(fileparts(which('fisherc')));
  %prtversion = {ver(prtoolsname) datestr(now)};
  prtversion = {'5.2.3' datestr(now)};
  PRTVERSION = prtversion;
%end
if nargout == 0
  disp(prtversion{1})
else
  out = prtversion;
end
