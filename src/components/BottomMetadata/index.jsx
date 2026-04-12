// Assets
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import "./index.css";
import { faFilm } from "@fortawesome/free-solid-svg-icons";

const BottomMetadata = ({ video, extraMetadata, secureHash }) => {
  let _metadata = { video_title: video.title };
  _metadata = { ..._metadata, ...extraMetadata };

  const handleClick = () => {
    if (!_metadata.video_link) return;
    window.open(_metadata.video_link, "_blank").focus();
  };

  return (
    <div className="bottom-metadata">
      {_metadata.channel_image && _metadata.channel_name && (
        <div className="channel" onClick={() => _metadata.channel_link && window.open(_metadata.channel_link, "_self")}>
          <div className="avatar-wrapper">
            <img src={`${_metadata.channel_image}${secureHash ? `?hash=${secureHash}` : ""}`} alt={_metadata.channel_name} />
          </div>
          <span>{_metadata.channel_name}</span>
        </div>
      )}
      {_metadata.video_caption && (
        <div
          className="video-caption"
          dangerouslySetInnerHTML={{ __html: _metadata.video_caption }}
        ></div>
      )}
    </div>
  );
};

export default BottomMetadata;
