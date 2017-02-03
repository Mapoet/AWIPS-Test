/**
 * Autogenerated by Thrift Compiler (0.9.0)
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *  @generated
 */

/*****************************************************************************************
 * COPYRIGHT (c), 2009, RAYTHEON COMPANY
 * ALL RIGHTS RESERVED, An Unpublished Work
 *
 * RAYTHEON PROPRIETARY
 * If the end user is not the U.S. Government or any agency thereof, use
 * or disclosure of data contained in this source code file is subject to
 * the proprietary restrictions set forth in the Master Rights File.
 *
 * U.S. GOVERNMENT PURPOSE RIGHTS NOTICE
 * If the end user is the U.S. Government or any agency thereof, this source
 * code is provided to the U.S. Government with Government Purpose Rights.
 * Use or disclosure of data contained in this source code file is subject to
 * the "Government Purpose Rights" restriction in the Master Rights File.
 *
 * U.S. EXPORT CONTROLLED TECHNICAL DATA
 * Use or disclosure of data contained in this source code file is subject to
 * the export restrictions set forth in the Master Rights File.
 ******************************************************************************************/

/*
 * Extended thrift protocol to handle messages from edex.
 *
 * <pre>
 *
 * SOFTWARE HISTORY
 *
 * Date         Ticket#     Engineer    Description
 * ------------ ----------  ----------- --------------------------
 * 07/29/13       2215       bkowal     Regenerated for thrift 0.9.0
 *
 * </pre>
 *
 * @author bkowal
 * @version 1
 */
#include "GribThriftRecord_types.h"

#include <algorithm>


const char* com_raytheon_uf_common_dataplugin_grib_GribThriftRecord::ascii_fingerprint = "5690BC677047F418DC04C0DF9712EC9C";
const uint8_t com_raytheon_uf_common_dataplugin_grib_GribThriftRecord::binary_fingerprint[16] = {0x56,0x90,0xBC,0x67,0x70,0x47,0xF4,0x18,0xDC,0x04,0xC0,0xDF,0x97,0x12,0xEC,0x9C};

uint32_t com_raytheon_uf_common_dataplugin_grib_GribThriftRecord::read(::apache::thrift::protocol::TProtocol* iprot) {

  uint32_t xfer = 0;
  std::string fname;
  ::apache::thrift::protocol::TType ftype;
  int16_t fid;

  xfer += iprot->readStructBegin(fname);

  using ::apache::thrift::protocol::TProtocolException;


  while (true)
  {
    xfer += iprot->readFieldBegin(fname, ftype, fid);
    if (ftype == ::apache::thrift::protocol::T_STOP) {
      break;
    }
    switch (fid)
    {
      case 1:
        if (ftype == ::apache::thrift::protocol::T_LIST) {
          {
            this->data.clear();
            uint32_t _size0;
            ::apache::thrift::protocol::TType _etype3;
            xfer += iprot->readListBegin(_etype3, _size0);
            this->data.resize(_size0);
            uint32_t _i4;
            for (_i4 = 0; _i4 < _size0; ++_i4)
            {
              xfer += iprot->readI32(this->data[_i4]);
            }
            xfer += iprot->readListEnd();
          }
          this->__isset.data = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 2:
        if (ftype == ::apache::thrift::protocol::T_LIST) {
          {
            this->trueData.clear();
            uint32_t _size5;
            ::apache::thrift::protocol::TType _etype8;
            xfer += iprot->readListBegin(_etype8, _size5);
            this->trueData.resize(_size5);
            uint32_t _i9;
            for (_i9 = 0; _i9 < _size5; ++_i9)
            {
              xfer += iprot->readDouble(this->trueData[_i9]);
            }
            xfer += iprot->readListEnd();
          }
          this->__isset.trueData = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 3:
        if (ftype == ::apache::thrift::protocol::T_BOOL) {
          xfer += iprot->readBool(this->hybridGrid);
          this->__isset.hybridGrid = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 4:
        if (ftype == ::apache::thrift::protocol::T_LIST) {
          {
            this->hybridGridData.clear();
            uint32_t _size10;
            ::apache::thrift::protocol::TType _etype13;
            xfer += iprot->readListBegin(_etype13, _size10);
            this->hybridGridData.resize(_size10);
            uint32_t _i14;
            for (_i14 = 0; _i14 < _size10; ++_i14)
            {
              xfer += iprot->readI32(this->hybridGridData[_i14]);
            }
            xfer += iprot->readListEnd();
          }
          this->__isset.hybridGridData = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 5:
        if (ftype == ::apache::thrift::protocol::T_LIST) {
          {
            this->trueHybridGridData.clear();
            uint32_t _size15;
            ::apache::thrift::protocol::TType _etype18;
            xfer += iprot->readListBegin(_etype18, _size15);
            this->trueHybridGridData.resize(_size15);
            uint32_t _i19;
            for (_i19 = 0; _i19 < _size15; ++_i19)
            {
              xfer += iprot->readDouble(this->trueHybridGridData[_i19]);
            }
            xfer += iprot->readListEnd();
          }
          this->__isset.trueHybridGridData = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 6:
        if (ftype == ::apache::thrift::protocol::T_BOOL) {
          xfer += iprot->readBool(this->localSection);
          this->__isset.localSection = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 7:
        if (ftype == ::apache::thrift::protocol::T_LIST) {
          {
            this->localSectionData.clear();
            uint32_t _size20;
            ::apache::thrift::protocol::TType _etype23;
            xfer += iprot->readListBegin(_etype23, _size20);
            this->localSectionData.resize(_size20);
            uint32_t _i24;
            for (_i24 = 0; _i24 < _size20; ++_i24)
            {
              xfer += iprot->readI32(this->localSectionData[_i24]);
            }
            xfer += iprot->readListEnd();
          }
          this->__isset.localSectionData = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 8:
        if (ftype == ::apache::thrift::protocol::T_STRUCT) {
          xfer += this->message.read(iprot);
          this->__isset.message = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 9:
        if (ftype == ::apache::thrift::protocol::T_BOOL) {
          xfer += iprot->readBool(this->thinnedGrid);
          this->__isset.thinnedGrid = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 10:
        if (ftype == ::apache::thrift::protocol::T_LIST) {
          {
            this->thinnedGridData.clear();
            uint32_t _size25;
            ::apache::thrift::protocol::TType _etype28;
            xfer += iprot->readListBegin(_etype28, _size25);
            this->thinnedGridData.resize(_size25);
            uint32_t _i29;
            for (_i29 = 0; _i29 < _size25; ++_i29)
            {
              xfer += iprot->readI32(this->thinnedGridData[_i29]);
            }
            xfer += iprot->readListEnd();
          }
          this->__isset.thinnedGridData = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      default:
        xfer += iprot->skip(ftype);
        break;
    }
    xfer += iprot->readFieldEnd();
  }

  xfer += iprot->readStructEnd();

  return xfer;
}

uint32_t com_raytheon_uf_common_dataplugin_grib_GribThriftRecord::write(::apache::thrift::protocol::TProtocol* oprot) const {
  uint32_t xfer = 0;
  xfer += oprot->writeStructBegin("com_raytheon_uf_common_dataplugin_grib_GribThriftRecord");

  xfer += oprot->writeFieldBegin("data", ::apache::thrift::protocol::T_LIST, 1);
  {
    xfer += oprot->writeListBegin(::apache::thrift::protocol::T_I32, static_cast<uint32_t>(this->data.size()));
    std::vector<int32_t> ::const_iterator _iter30;
    for (_iter30 = this->data.begin(); _iter30 != this->data.end(); ++_iter30)
    {
      xfer += oprot->writeI32((*_iter30));
    }
    xfer += oprot->writeListEnd();
  }
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldBegin("trueData", ::apache::thrift::protocol::T_LIST, 2);
  {
    xfer += oprot->writeListBegin(::apache::thrift::protocol::T_DOUBLE, static_cast<uint32_t>(this->trueData.size()));
    std::vector<double> ::const_iterator _iter31;
    for (_iter31 = this->trueData.begin(); _iter31 != this->trueData.end(); ++_iter31)
    {
      xfer += oprot->writeDouble((*_iter31));
    }
    xfer += oprot->writeListEnd();
  }
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldBegin("hybridGrid", ::apache::thrift::protocol::T_BOOL, 3);
  xfer += oprot->writeBool(this->hybridGrid);
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldBegin("hybridGridData", ::apache::thrift::protocol::T_LIST, 4);
  {
    xfer += oprot->writeListBegin(::apache::thrift::protocol::T_I32, static_cast<uint32_t>(this->hybridGridData.size()));
    std::vector<int32_t> ::const_iterator _iter32;
    for (_iter32 = this->hybridGridData.begin(); _iter32 != this->hybridGridData.end(); ++_iter32)
    {
      xfer += oprot->writeI32((*_iter32));
    }
    xfer += oprot->writeListEnd();
  }
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldBegin("trueHybridGridData", ::apache::thrift::protocol::T_LIST, 5);
  {
    xfer += oprot->writeListBegin(::apache::thrift::protocol::T_DOUBLE, static_cast<uint32_t>(this->trueHybridGridData.size()));
    std::vector<double> ::const_iterator _iter33;
    for (_iter33 = this->trueHybridGridData.begin(); _iter33 != this->trueHybridGridData.end(); ++_iter33)
    {
      xfer += oprot->writeDouble((*_iter33));
    }
    xfer += oprot->writeListEnd();
  }
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldBegin("localSection", ::apache::thrift::protocol::T_BOOL, 6);
  xfer += oprot->writeBool(this->localSection);
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldBegin("localSectionData", ::apache::thrift::protocol::T_LIST, 7);
  {
    xfer += oprot->writeListBegin(::apache::thrift::protocol::T_I32, static_cast<uint32_t>(this->localSectionData.size()));
    std::vector<int32_t> ::const_iterator _iter34;
    for (_iter34 = this->localSectionData.begin(); _iter34 != this->localSectionData.end(); ++_iter34)
    {
      xfer += oprot->writeI32((*_iter34));
    }
    xfer += oprot->writeListEnd();
  }
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldBegin("message", ::apache::thrift::protocol::T_STRUCT, 8);
  xfer += this->message.write(oprot);
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldBegin("thinnedGrid", ::apache::thrift::protocol::T_BOOL, 9);
  xfer += oprot->writeBool(this->thinnedGrid);
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldBegin("thinnedGridData", ::apache::thrift::protocol::T_LIST, 10);
  {
    xfer += oprot->writeListBegin(::apache::thrift::protocol::T_I32, static_cast<uint32_t>(this->thinnedGridData.size()));
    std::vector<int32_t> ::const_iterator _iter35;
    for (_iter35 = this->thinnedGridData.begin(); _iter35 != this->thinnedGridData.end(); ++_iter35)
    {
      xfer += oprot->writeI32((*_iter35));
    }
    xfer += oprot->writeListEnd();
  }
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldStop();
  xfer += oprot->writeStructEnd();
  return xfer;
}

void swap(com_raytheon_uf_common_dataplugin_grib_GribThriftRecord &a, com_raytheon_uf_common_dataplugin_grib_GribThriftRecord &b) {
  using ::std::swap;
  swap(a.data, b.data);
  swap(a.trueData, b.trueData);
  swap(a.hybridGrid, b.hybridGrid);
  swap(a.hybridGridData, b.hybridGridData);
  swap(a.trueHybridGridData, b.trueHybridGridData);
  swap(a.localSection, b.localSection);
  swap(a.localSectionData, b.localSectionData);
  swap(a.message, b.message);
  swap(a.thinnedGrid, b.thinnedGrid);
  swap(a.thinnedGridData, b.thinnedGridData);
  swap(a.__isset, b.__isset);
}

