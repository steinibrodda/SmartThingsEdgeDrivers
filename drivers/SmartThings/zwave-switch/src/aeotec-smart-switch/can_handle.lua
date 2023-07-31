-- Copyright 2023 SmartThings
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
local FINGERPRINTS = {
  {mfr = 0x0086, prodId = 0x0060},
  {mfr = 0x0371, prodId = 0x00AF},
  {mfr = 0x0371, prodId = 0x0017}
}

local function can_handle(opts, driver, device, ...)
  for _, fingerprint in ipairs(FINGERPRINTS) do
    if device:id_match(fingerprint.mfr, nil, fingerprint.prodId) then
      local subdriver = require("aeotec-smart-switch")
      return true, subdriver
    end
  end
  return false
end

local subdriver = {
  NAME = "Aeotec Smart Switch",
  can_handle = can_handle,
  -- TODO: The concept of lazy loading might be something that shoould be abstracted from the driver? (i.e. not lazy_load flag should be here?)
  lazy_load = true
}

return subdriver
