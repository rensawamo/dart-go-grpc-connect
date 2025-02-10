// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.35.1
// 	protoc        (unknown)
// source: eliza/v1/eliza.proto

package elizav1

import (
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	reflect "reflect"
	sync "sync"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

type SayRequest struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Sentence string `protobuf:"bytes,1,opt,name=sentence,proto3" json:"sentence,omitempty"`
}

func (x *SayRequest) Reset() {
	*x = SayRequest{}
	mi := &file_eliza_v1_eliza_proto_msgTypes[0]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *SayRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*SayRequest) ProtoMessage() {}

func (x *SayRequest) ProtoReflect() protoreflect.Message {
	mi := &file_eliza_v1_eliza_proto_msgTypes[0]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use SayRequest.ProtoReflect.Descriptor instead.
func (*SayRequest) Descriptor() ([]byte, []int) {
	return file_eliza_v1_eliza_proto_rawDescGZIP(), []int{0}
}

func (x *SayRequest) GetSentence() string {
	if x != nil {
		return x.Sentence
	}
	return ""
}

type SayResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Sentence string `protobuf:"bytes,1,opt,name=sentence,proto3" json:"sentence,omitempty"`
}

func (x *SayResponse) Reset() {
	*x = SayResponse{}
	mi := &file_eliza_v1_eliza_proto_msgTypes[1]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *SayResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*SayResponse) ProtoMessage() {}

func (x *SayResponse) ProtoReflect() protoreflect.Message {
	mi := &file_eliza_v1_eliza_proto_msgTypes[1]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use SayResponse.ProtoReflect.Descriptor instead.
func (*SayResponse) Descriptor() ([]byte, []int) {
	return file_eliza_v1_eliza_proto_rawDescGZIP(), []int{1}
}

func (x *SayResponse) GetSentence() string {
	if x != nil {
		return x.Sentence
	}
	return ""
}

var File_eliza_v1_eliza_proto protoreflect.FileDescriptor

var file_eliza_v1_eliza_proto_rawDesc = []byte{
	0x0a, 0x14, 0x65, 0x6c, 0x69, 0x7a, 0x61, 0x2f, 0x76, 0x31, 0x2f, 0x65, 0x6c, 0x69, 0x7a, 0x61,
	0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x12, 0x08, 0x65, 0x6c, 0x69, 0x7a, 0x61, 0x2e, 0x76, 0x31,
	0x22, 0x28, 0x0a, 0x0a, 0x53, 0x61, 0x79, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x12, 0x1a,
	0x0a, 0x08, 0x73, 0x65, 0x6e, 0x74, 0x65, 0x6e, 0x63, 0x65, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09,
	0x52, 0x08, 0x73, 0x65, 0x6e, 0x74, 0x65, 0x6e, 0x63, 0x65, 0x22, 0x29, 0x0a, 0x0b, 0x53, 0x61,
	0x79, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x1a, 0x0a, 0x08, 0x73, 0x65, 0x6e,
	0x74, 0x65, 0x6e, 0x63, 0x65, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x52, 0x08, 0x73, 0x65, 0x6e,
	0x74, 0x65, 0x6e, 0x63, 0x65, 0x32, 0x44, 0x0a, 0x0c, 0x45, 0x6c, 0x69, 0x7a, 0x61, 0x53, 0x65,
	0x72, 0x76, 0x69, 0x63, 0x65, 0x12, 0x34, 0x0a, 0x03, 0x53, 0x61, 0x79, 0x12, 0x14, 0x2e, 0x65,
	0x6c, 0x69, 0x7a, 0x61, 0x2e, 0x76, 0x31, 0x2e, 0x53, 0x61, 0x79, 0x52, 0x65, 0x71, 0x75, 0x65,
	0x73, 0x74, 0x1a, 0x15, 0x2e, 0x65, 0x6c, 0x69, 0x7a, 0x61, 0x2e, 0x76, 0x31, 0x2e, 0x53, 0x61,
	0x79, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x22, 0x00, 0x42, 0xa3, 0x01, 0x0a, 0x0c,
	0x63, 0x6f, 0x6d, 0x2e, 0x65, 0x6c, 0x69, 0x7a, 0x61, 0x2e, 0x76, 0x31, 0x42, 0x0a, 0x45, 0x6c,
	0x69, 0x7a, 0x61, 0x50, 0x72, 0x6f, 0x74, 0x6f, 0x50, 0x01, 0x5a, 0x46, 0x67, 0x69, 0x74, 0x68,
	0x75, 0x62, 0x2e, 0x63, 0x6f, 0x6d, 0x2f, 0x72, 0x65, 0x6e, 0x73, 0x61, 0x77, 0x61, 0x6d, 0x6f,
	0x2f, 0x64, 0x61, 0x72, 0x74, 0x2d, 0x67, 0x6f, 0x2d, 0x67, 0x72, 0x70, 0x63, 0x2d, 0x63, 0x6f,
	0x6e, 0x6e, 0x65, 0x63, 0x74, 0x2f, 0x62, 0x61, 0x63, 0x6b, 0x65, 0x6e, 0x64, 0x2f, 0x67, 0x65,
	0x6e, 0x2f, 0x65, 0x6c, 0x69, 0x7a, 0x61, 0x2f, 0x76, 0x31, 0x3b, 0x65, 0x6c, 0x69, 0x7a, 0x61,
	0x76, 0x31, 0xa2, 0x02, 0x03, 0x45, 0x58, 0x58, 0xaa, 0x02, 0x08, 0x45, 0x6c, 0x69, 0x7a, 0x61,
	0x2e, 0x56, 0x31, 0xca, 0x02, 0x08, 0x45, 0x6c, 0x69, 0x7a, 0x61, 0x5c, 0x56, 0x31, 0xe2, 0x02,
	0x14, 0x45, 0x6c, 0x69, 0x7a, 0x61, 0x5c, 0x56, 0x31, 0x5c, 0x47, 0x50, 0x42, 0x4d, 0x65, 0x74,
	0x61, 0x64, 0x61, 0x74, 0x61, 0xea, 0x02, 0x09, 0x45, 0x6c, 0x69, 0x7a, 0x61, 0x3a, 0x3a, 0x56,
	0x31, 0x62, 0x06, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x33,
}

var (
	file_eliza_v1_eliza_proto_rawDescOnce sync.Once
	file_eliza_v1_eliza_proto_rawDescData = file_eliza_v1_eliza_proto_rawDesc
)

func file_eliza_v1_eliza_proto_rawDescGZIP() []byte {
	file_eliza_v1_eliza_proto_rawDescOnce.Do(func() {
		file_eliza_v1_eliza_proto_rawDescData = protoimpl.X.CompressGZIP(file_eliza_v1_eliza_proto_rawDescData)
	})
	return file_eliza_v1_eliza_proto_rawDescData
}

var file_eliza_v1_eliza_proto_msgTypes = make([]protoimpl.MessageInfo, 2)
var file_eliza_v1_eliza_proto_goTypes = []any{
	(*SayRequest)(nil),  // 0: eliza.v1.SayRequest
	(*SayResponse)(nil), // 1: eliza.v1.SayResponse
}
var file_eliza_v1_eliza_proto_depIdxs = []int32{
	0, // 0: eliza.v1.ElizaService.Say:input_type -> eliza.v1.SayRequest
	1, // 1: eliza.v1.ElizaService.Say:output_type -> eliza.v1.SayResponse
	1, // [1:2] is the sub-list for method output_type
	0, // [0:1] is the sub-list for method input_type
	0, // [0:0] is the sub-list for extension type_name
	0, // [0:0] is the sub-list for extension extendee
	0, // [0:0] is the sub-list for field type_name
}

func init() { file_eliza_v1_eliza_proto_init() }
func file_eliza_v1_eliza_proto_init() {
	if File_eliza_v1_eliza_proto != nil {
		return
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_eliza_v1_eliza_proto_rawDesc,
			NumEnums:      0,
			NumMessages:   2,
			NumExtensions: 0,
			NumServices:   1,
		},
		GoTypes:           file_eliza_v1_eliza_proto_goTypes,
		DependencyIndexes: file_eliza_v1_eliza_proto_depIdxs,
		MessageInfos:      file_eliza_v1_eliza_proto_msgTypes,
	}.Build()
	File_eliza_v1_eliza_proto = out.File
	file_eliza_v1_eliza_proto_rawDesc = nil
	file_eliza_v1_eliza_proto_goTypes = nil
	file_eliza_v1_eliza_proto_depIdxs = nil
}
